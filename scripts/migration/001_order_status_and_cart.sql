-- 001: Orders 補 status／收件資訊欄位，新增 CartItem
-- 適用於已用 2026-08 版 create_table.sql 建好的資料庫；全新環境直接跑 create_table.sql 即可。
-- 既有訂單補預設值：status=pending、deliveryID=1（7-11）、收件資訊空字串。

START TRANSACTION;

ALTER TABLE Orders
    ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'pending' AFTER total,
    ADD COLUMN deliveryID INT NOT NULL DEFAULT 1 AFTER status,
    ADD COLUMN storeName VARCHAR(255) NOT NULL DEFAULT '' AFTER deliveryID,
    ADD COLUMN receiverName VARCHAR(255) NOT NULL DEFAULT '' AFTER storeName,
    ADD COLUMN receiverPhone VARCHAR(20) NOT NULL DEFAULT '' AFTER receiverName,
    ADD CONSTRAINT FK_B2BDelivery_Orders FOREIGN KEY (deliveryID) REFERENCES B2BDelivery(deliveryID);

ALTER TABLE Orders
    ALTER COLUMN deliveryID DROP DEFAULT,
    ALTER COLUMN storeName DROP DEFAULT,
    ALTER COLUMN receiverName DROP DEFAULT,
    ALTER COLUMN receiverPhone DROP DEFAULT;

CREATE TABLE IF NOT EXISTS CartItem (
    cartItemID INT NOT NULL AUTO_INCREMENT,
    accID INT NOT NULL,
    productID INT NOT NULL,
    num INT NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_CartItem PRIMARY KEY (cartItemID),
    CONSTRAINT FK_Account_CartItem FOREIGN KEY (accID) REFERENCES Account(accID),
    CONSTRAINT FK_Product_CartItem FOREIGN KEY (productID) REFERENCES Product(productID),
    UNIQUE (accID, productID)
);

COMMIT;
