-- 002: Product 補 status 欄位（1=上架、0=下架），既有商品預設上架
START TRANSACTION;

ALTER TABLE Product
    ADD COLUMN status TINYINT NOT NULL DEFAULT 1 AFTER spec;

COMMIT;
