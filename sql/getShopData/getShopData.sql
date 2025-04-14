DROP PROCEDURE IF EXISTS getShopData;
-- The Services of a Barbershop
DELIMITER $$
CREATE PROCEDURE getShopData(IN business_id INT)
BEGIN
  -- Selects business name and image for specific `business_id`
  SELECT businesses.name AS business_name, logo AS business_logo
  FROM businesses
  LEFT JOIN images
  ON images.id = businesses.logo
  WHERE businesses.id = business_id;
  
  -- Selects services for the specific business
  SELECT label AS service_name, price, lasts AS service_duration, services.img AS service_img
  FROM businesses INNER JOIN businesses_have_services
  ON businesses.id = businesses_have_services.business_id
  INNER JOIN services
  ON businesses_have_services.service_id = services.id
  WHERE businesses.id = business_id;
  
  -- Selects shops for the specific business
  SELECT 
    shops.name, opening_time, closing_time,
    addresses.street, addresses.street_number, addresses.city, addresses.suburb, addresses.postal_code,
    phones.value, images.path AS image_src, images.name AS image_description
  FROM businesses
  INNER JOIN shops
  ON businesses.id = shops.business_id
  INNER JOIN addresses
  ON shops.address = addresses.id
  INNER JOIN phones
  ON shops.id = phones.shop_id
  INNER JOIN images
  ON images.id = businesses.logo OR images.id = shops.img
  WHERE businesses.id = business_id; 

  -- Selects barbers for a specific business and groups them by shop_id
  SELECT barbers.shop, barbers.name AS barber_name, images.path AS barber_image
  FROM businesses
  INNER JOIN shops
  ON businesses.id = shops.business_id
  INNER JOIN addresses
  ON shops.address = addresses.id
  INNER JOIN phones
  ON shops.id = phones.shop_id
  INNER JOIN barbers
  ON barbers.shop = shops.id
  INNER JOIN images
  ON images.id = businesses.logo OR images.id = shops.img OR barbers.img = images.id
  WHERE businesses.id = business_id;
END $$
DELIMITER ;

CALL getShopData(1)