/*
  Data Cleansing & Normalization Script
  Objective: Cleanse property_transactions dataset
*/

-- 1. Standardize Transaction Date Format
ALTER TABLE property_transactions
ADD transaction_date_converted Date;

UPDATE property_transactions
SET transaction_date_converted = CONVERT(Date, transaction_date);


-- 2. Populate Missing Property Addresses Using Parcel ID Self-Join
-- Some rows are missing the address but share the same ParcelID as other rows.
UPDATE a
SET property_address = ISNULL(a.property_address, b.property_address)
FROM property_transactions a
JOIN property_transactions b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.property_address IS NULL;


-- 3. Breaking out Address into Individual Columns (Address, City, State)
ALTER TABLE property_transactions
ADD property_split_address Nvarchar(255),
    property_split_city Nvarchar(255);

UPDATE property_transactions
SET property_split_address = SUBSTRING(property_address, 1, CHARINDEX(',', property_address) - 1),
    property_split_city = SUBSTRING(property_address, CHARINDEX(',', property_address) + 1, LEN(property_address));


-- 4. Remove Duplicates utilizing CTE and ROW_NUMBER()
WITH RowNumCTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY ParcelID,
                         property_address,
                         sale_price,
                         transaction_date,
                         LegalReference
            ORDER BY UniqueID
        ) as row_num
    FROM property_transactions
)
DELETE
FROM RowNumCTE
WHERE row_num > 1;

-- 5. Drop Unused Legacy Columns
ALTER TABLE property_transactions
DROP COLUMN property_address, TaxDistrict, transaction_date;
