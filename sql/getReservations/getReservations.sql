/*
 * Accepts a shop_id, some_date, barber_id and retrieves the opening_time and closing_time
 * @param shop_id - The id of the shop to retrieve the opening_time and closing_time
 * @param barber_id - The barber_id that we will retrieve his reservations
 * @param some_date - The date to extract the working hours for the month 
 */
DROP PROCEDURE IF EXISTS getReservations;
-- The Dates of the month
DELIMITER $$
CREATE PROCEDURE getReservations(IN shop_id INT, IN barber_id INT,IN some_date DATE)
BEGIN
  -- Selects opening_time and closing_time for `shop_id`
  SELECT opening_time, closing_time 
  FROM shops
  WHERE shops.id = business_id;
  
  -- Selects services for the specific business
  SELECT reservation_date AS r_date, reservation_time as r_time
  FROM reservations 
  WHERE YEAR(some_date) = YEAR(reservation_date)
  AND MONTH(some_date) = MONTH(reservation_date)
  AND reservations.barber_id = barber_id;
END $$
DELIMITER ;

CALL getReservations(1,1,"2025-04-09")