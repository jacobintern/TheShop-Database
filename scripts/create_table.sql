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
    isDefault BOOLEAN,
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

-- 商品圖片
CREATE TABLE ProductImgs (
    imgID INT NOT NULL AUTO_INCREMENT,
    productID INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    type TINYINT(1) NOT NULL,
    url VARCHAR(255) NOT NULL,
    createTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateTime DATETIME NULL,
    CONSTRAINT PK_ProductImg PRIMARY KEY(imgID)
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


START TRANSACTION;
insert into Products(name, price, stock, spec) values('product A', 1.00, 10, 'product A description');
insert into Products(name, price, stock, spec) values('product B', 2.00, 20, 'product B description');
insert into Products(name, price, stock, spec) values('product C', 3.00, 30, 'product C description');
insert into Products(name, price, stock, spec) values('product D', 4.00, 40, 'product D description');
insert into Products(name, price, stock, spec) values('product E', 5.00, 50, 'product E description');
insert into Products(name, price, stock, spec) values('product F', 6.00, 60, 'product F description');
insert into Products(name, price, stock, spec) values('product G', 7.00, 70, 'product G description');
insert into Products(name, price, stock, spec) values('product H', 8.00, 80, 'product H description');
insert into Products(name, price, stock, spec) values('product I', 9.00, 90, 'product I description');

COMMIT;

START TRANSACTION;
insert into ProductImgs(productID, name, type, url) values(1, 'banner A', 0, 'https://memes.tw/user-text-tmp/1701315859722.png');
insert into ProductImgs(productID, name, type, url) values(1, 'content A', 1, 'https://memes.tw/user-text-tmp/1701325529594.png');
insert into ProductImgs(productID, name, type, url) values(2, 'banner B', 0, 'https://memes.tw/user-text-tmp/1701325565805.png');
insert into ProductImgs(productID, name, type, url) values(2, 'content B', 1, 'https://memes.tw/user-text-tmp/1701325704158.png');
insert into ProductImgs(productID, name, type, url) values(3, 'banner C', 0, 'https://memes.tw/user-text-tmp/1701325578286.png');
insert into ProductImgs(productID, name, type, url) values(3, 'content C', 1, 'https://memes.tw/user-text-tmp/1701325713899.png');
insert into ProductImgs(productID, name, type, url) values(4, 'banner D', 0, 'https://memes.tw/user-text-tmp/1701325591362.png');
insert into ProductImgs(productID, name, type, url) values(4, 'content D', 1, 'https://memes.tw/user-text-tmp/1701325721109.png');
insert into ProductImgs(productID, name, type, url) values(5, 'banner E', 0, 'https://memes.tw/user-text-tmp/1701325600931.png');
insert into ProductImgs(productID, name, type, url) values(5, 'content E', 1, 'https://memes.tw/user-text-tmp/1701325728589.png');
insert into ProductImgs(productID, name, type, url) values(6, 'banner F', 0, 'https://memes.tw/user-text-tmp/1701325660041.png');
insert into ProductImgs(productID, name, type, url) values(6, 'content F', 1, 'https://memes.tw/user-text-tmp/1701325735979.png');
insert into ProductImgs(productID, name, type, url) values(7, 'banner G', 0, 'https://memes.tw/user-text-tmp/1701325670890.png');
insert into ProductImgs(productID, name, type, url) values(7, 'content G', 1, 'https://memes.tw/user-text-tmp/1701325744264.png');
insert into ProductImgs(productID, name, type, url) values(8, 'banner H', 0, 'https://memes.tw/user-text-tmp/1701325680227.png');
insert into ProductImgs(productID, name, type, url) values(8, 'content H', 1, 'https://memes.tw/user-text-tmp/1701325752550.png');
insert into ProductImgs(productID, name, type, url) values(9, 'banner I', 0, 'https://memes.tw/user-text-tmp/1701325688306.png');
insert into ProductImgs(productID, name, type, url) values(9, 'content I', 1, 'https://memes.tw/user-text-tmp/1701325762085.png');
COMMIT;