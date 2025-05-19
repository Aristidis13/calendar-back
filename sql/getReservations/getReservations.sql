DROP PROCEDURE IF EXISTS getReservations;
-- The Dates of the month
DELIMITER $$
CREATE PROCEDURE getReservations(IN shop_id INT, IN barberId INT,IN some_date DATE)
BEGIN
  -- Selects opening_time and closing_time for `shop_id`
  SELECT opening_time, closing_time 
  FROM shops
  WHERE shops.id = business_id;
  
  -- Selects services for the specific business
  SELECT reservation_date AS r_date, reservation_time as r_time
  FROM reservations 
  WHERE YEAR(some_date) = YEAR(reservation_date)
  AND MONTH(some_date) = MONTH(reservation_date);
END $$
DELIMITER ;

CALL getReservations(1,1,"2025-04-09")