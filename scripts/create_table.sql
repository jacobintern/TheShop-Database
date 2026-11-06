START TRANSACTION;

-- 會員
CREATE TABLE Account (
    accID INT NOT NULL AUTO_INCREMENT,
    account VARCHAR(255) NOT NULL,
    pswd VARCHAR(100) NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT PK_Accounts PRIMARY KEY(accID),
    UNIQUE(account)
);

-- 會員資訊
CREATE TABLE Member (
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
    CONSTRAINT FK_Account_Member FOREIGN KEY(accID) REFERENCES Account(accID),
    UNIQUE(accID),
    UNIQUE(id)
);

-- 店到店運送資訊
CREATE TABLE B2BDelivery (
    deliveryID INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_B2BDelivery PRIMARY KEY (deliveryID)
);

-- 會員運送資訊
CREATE TABLE DeliveryPrefer (
    preferID INT NOT NULL AUTO_INCREMENT,
    memberID INT NOT NULL,
    deliveryID INT NOT NULL,
    isDefault BOOLEAN,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_DeliveryPrefer PRIMARY KEY(preferID),
    CONSTRAINT FK_Member_DeliveryPrefer FOREIGN KEY(memberID) REFERENCES Member(memberID),
    CONSTRAINT FK_B2BDelivery_DeliveryPrefer FOREIGN KEY(deliveryID) REFERENCES B2BDelivery(deliveryID)
);

-- 商品資訊
CREATE TABLE Product (
    productID INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    stock INT NOT NULL,
    spec TEXT,
    -- 1=上架、0=下架
    status TINYINT NOT NULL DEFAULT 1,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_Product PRIMARY KEY (productID)
);

-- 商品圖片
CREATE TABLE ProductImg (
    imgID INT NOT NULL AUTO_INCREMENT,
    productID INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    type TINYINT(1) NOT NULL,
    url VARCHAR(255) NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_ProductImg PRIMARY KEY(imgID),
    CONSTRAINT FK_Product_ProductImg FOREIGN KEY(productID) REFERENCES Product(productID)
);

-- 庫存更新日誌
CREATE TABLE StockTracking (
    trackID INT NOT NULL AUTO_INCREMENT,
    productID INT NOT NULL,
    beforeValue INT NOT NULL,
    afterValue INT NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT PK_StockTracking PRIMARY KEY(trackID),
    CONSTRAINT FK_Product_StockTracking FOREIGN KEY(productID) REFERENCES Product(productID)
);

-- 訂單
CREATE TABLE Orders (
    orderID INT NOT NULL AUTO_INCREMENT,
    accID INT NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    -- pending / paid / shipped / completed / cancelled
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    deliveryID INT NOT NULL,
    storeName VARCHAR(255) NOT NULL,
    receiverName VARCHAR(255) NOT NULL,
    receiverPhone VARCHAR(20) NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_Orders PRIMARY KEY(orderID),
    CONSTRAINT FK_Account_Orders FOREIGN KEY(accID) REFERENCES Account(accID),
    CONSTRAINT FK_B2BDelivery_Orders FOREIGN KEY(deliveryID) REFERENCES B2BDelivery(deliveryID)
);

-- 訂單明細
CREATE TABLE OrderBody (
    bodyID INT NOT NULL AUTO_INCREMENT,
    productID INT NOT NULL,
    orderID INT NOT NULL,
    num INT NOT NULL,
    subTotal DECIMAL(12,2) NOT NULL,
    CONSTRAINT PK_OrderBody PRIMARY KEY(bodyID),
    CONSTRAINT FK_Product_OrderBody FOREIGN KEY(productID) REFERENCES Product(productID),
    CONSTRAINT FK_Orders_OrderBody FOREIGN KEY(orderID) REFERENCES Orders(orderID)
);

-- 購物車
CREATE TABLE CartItem (
    cartItemID INT NOT NULL AUTO_INCREMENT,
    accID INT NOT NULL,
    productID INT NOT NULL,
    num INT NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_CartItem PRIMARY KEY(cartItemID),
    CONSTRAINT FK_Account_CartItem FOREIGN KEY(accID) REFERENCES Account(accID),
    CONSTRAINT FK_Product_CartItem FOREIGN KEY(productID) REFERENCES Product(productID),
    UNIQUE(accID, productID)
);

COMMIT;

START TRANSACTION;
INSERT INTO Product(name, price, stock, spec) VALUES('product A', 1.00, 10, 'product A description');
INSERT INTO Product(name, price, stock, spec) VALUES('product B', 2.00, 20, 'product B description');
INSERT INTO Product(name, price, stock, spec) VALUES('product C', 3.00, 30, 'product C description');
INSERT INTO Product(name, price, stock, spec) VALUES('product D', 4.00, 40, 'product D description');
INSERT INTO Product(name, price, stock, spec) VALUES('product E', 5.00, 50, 'product E description');
INSERT INTO Product(name, price, stock, spec) VALUES('product F', 6.00, 60, 'product F description');
INSERT INTO Product(name, price, stock, spec) VALUES('product G', 7.00, 70, 'product G description');
INSERT INTO Product(name, price, stock, spec) VALUES('product H', 8.00, 80, 'product H description');
INSERT INTO Product(name, price, stock, spec) VALUES('product I', 9.00, 90, 'product I description');

COMMIT;

START TRANSACTION;
INSERT INTO ProductImg(productID, name, type, url) VALUES(1, 'banner A', 0, 'https://memes.tw/user-text-tmp/1701315859722.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(1, 'content A', 1, 'https://memes.tw/user-text-tmp/1701325529594.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(2, 'banner B', 0, 'https://memes.tw/user-text-tmp/1701325565805.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(2, 'content B', 1, 'https://memes.tw/user-text-tmp/1701325704158.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(3, 'banner C', 0, 'https://memes.tw/user-text-tmp/1701325578286.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(3, 'content C', 1, 'https://memes.tw/user-text-tmp/1701325713899.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(4, 'banner D', 0, 'https://memes.tw/user-text-tmp/1701325591362.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(4, 'content D', 1, 'https://memes.tw/user-text-tmp/1701325721109.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(5, 'banner E', 0, 'https://memes.tw/user-text-tmp/1701325600931.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(5, 'content E', 1, 'https://memes.tw/user-text-tmp/1701325728589.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(6, 'banner F', 0, 'https://memes.tw/user-text-tmp/1701325660041.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(6, 'content F', 1, 'https://memes.tw/user-text-tmp/1701325735979.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(7, 'banner G', 0, 'https://memes.tw/user-text-tmp/1701325670890.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(7, 'content G', 1, 'https://memes.tw/user-text-tmp/1701325744264.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(8, 'banner H', 0, 'https://memes.tw/user-text-tmp/1701325680227.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(8, 'content H', 1, 'https://memes.tw/user-text-tmp/1701325752550.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(9, 'banner I', 0, 'https://memes.tw/user-text-tmp/1701325688306.png');
INSERT INTO ProductImg(productID, name, type, url) VALUES(9, 'content I', 1, 'https://memes.tw/user-text-tmp/1701325762085.png');
COMMIT;

START TRANSACTION;

insert into B2BDelivery(name) values(N'7-11');
insert into B2BDelivery(name) values(N'全家');
insert into B2BDelivery(name) values(N'OK');
insert into B2BDelivery(name) values(N'萊爾富');
insert into B2BDelivery(name) values(N'蝦皮');

COMMIT;
