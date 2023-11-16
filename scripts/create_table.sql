START TRANSACTION;

-- 會員
CREATE TABLE Accounts (
    accID INT NOT NULL AUTO_INCREMENT,
    account VARCHAR(255) NOT NULL,
    pswd VARCHAR(100) NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT PK_Accounts PRIMARY KEY(accID),
    UNIQUE(Account)
);

-- 會員資訊
CREATE TABLE Members (
    memberID INT NOT NULL AUTO_INCREMENT,
    accID INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    live VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    id VARCHAR(20) NOT NULL, 
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_Members PRIMARY KEY(memberID),
    CONSTRAINT FK_Accounts_Members FOREIGN KEY(accID) REFERENCES Accounts(accID),
    UNIQUE(id)
);

-- 店到店運送資訊
CREATE TABLE B2BDelivery (
    deliveryID INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_B2BDelivery PRIMARY KEY(deliveryID)
);

-- 會員運送資訊
CREATE TABLE DeliveryPrefer (
    preferID INT NOT NULL AUTO_INCREMENT,
    memberID INT NOT NULL,
    deliveryID INT NOT NULL,
    isSelected BOOLEAN,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_DeliveryPrefer PRIMARY KEY(preferID),
    CONSTRAINT FK_Members_DeliveryPrefer FOREIGN KEY(memberID) REFERENCES Members(memberID),
    CONSTRAINT FK_B2BDelivery_DeliveryPrefer FOREIGN KEY(deliveryID) REFERENCES B2BDelivery(deliveryID)
);

-- 商品資訊
CREATE TABLE Products (
    productID INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    stock INT NOT NULL,
    spec TEXT,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_Products PRIMARY KEY(productID)
);

-- 庫存更新日誌
CREATE TABLE StockTracking (
    trackID INT NOT NULL AUTO_INCREMENT,
    productID INT NOT NULL,
    beforeValue INT NOT NULL,
    afterValue INT NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT PK_StockTracking PRIMARY KEY(trackID),
    CONSTRAINT FK_Products_StockTracking FOREIGN KEY(productID) REFERENCES Products(productID)
);

-- 商品圖片
CREATE TABLE ProductImgs (
    imgID INT NOT NULL AUTO_INCREMENT,
    productID INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_ProductImg PRIMARY KEY(imgID)
);

-- 訂單
CREATE TABLE Orders (
    orderID INT NOT NULL AUTO_INCREMENT,
    accID INT NOT NULL,
    total DECIMAL(6,2) NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_Order PRIMARY KEY(orderID),
    CONSTRAINT FK_Accounts_Orders FOREIGN KEY(accID) REFERENCES Accounts(accID)
);

-- 訂單明細
CREATE TABLE OrderBody (
    bodyID INT NOT NULL AUTO_INCREMENT,
    productID INT NOT NULL,
    orderID INT NOT NULL,
    num INT NOT NULL,
    subTotal DECIMAL(6,2) NOT NULL,
    CONSTRAINT PK_OrderBody PRIMARY KEY(bodyID),
    CONSTRAINT FK_Products_OrderBody FOREIGN KEY(productID) REFERENCES Products(productID),
    CONSTRAINT FK_Orders_OrderBody FOREIGN KEY(orderID) REFERENCES Orders(orderID)
);

COMMIT;