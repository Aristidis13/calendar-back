DROP DATABASE IF EXISTS bookings;
CREATE DATABASE IF NOT EXISTS bookings;
USE bookings;

CREATE TABLE IF NOT EXISTS addresses (
  id SERIAL PRIMARY KEY,
  street VARCHAR(50) NOT NULL,
  street_number SMALLINT NOT NULL,
  city VARCHAR(30) NOT NULL,
  suburb VARCHAR(30) NULL,
  postal_code SMALLINT NOT NULL
);

CREATE TABLE IF NOT EXISTS customer (
  id SERIAL PRIMARY KEY,
  phone TINYINT(10) NOT NULL,
  email VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS comment (
  id SERIAL PRIMARY KEY,
  customer_id BIGINT UNSIGNED NOT NULL NOT NULL,
  comment_value VARCHAR(200) NOT NULL,
  CONSTRAINT customer_comment FOREIGN KEY (customer_id) REFERENCES customer (id)
);

/*
 * The images Table holds information about images
 */
CREATE TABLE IF NOT EXISTS images (
  id SERIAL PRIMARY KEY,
  path VARCHAR(255) NOT NULL,
  name VARCHAR(150) DEFAULT ''
);

CREATE TABLE IF NOT EXISTS businesses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  added TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  logo BIGINT UNSIGNED NOT NULL,
  CONSTRAINT business_img FOREIGN KEY (logo) REFERENCES images (id)
);

CREATE TABLE IF NOT EXISTS services (
  id SMALLINT UNSIGNED UNIQUE NOT NULL PRIMARY KEY,
  label VARCHAR(150) NOT NULL,
  price DECIMAL(4,2) NOT NULL,
  lasts TIME NOT NULL DEFAULT "00:30:00",
  img BIGINT UNSIGNED NOT NULL,
  CONSTRAINT service_img FOREIGN KEY (img) REFERENCES images (id)
);

CREATE TABLE IF NOT EXISTS businesses_have_services (
  business_id BIGINT UNSIGNED NOT NULL,
  service_id SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (business_id, service_id),
  CONSTRAINT business_have_services FOREIGN KEY (service_id) REFERENCES services (id),
  CONSTRAINT service_for_businesses FOREIGN KEY (business_id) REFERENCES businesses (id)
);

CREATE TABLE IF NOT EXISTS shops (
  id SERIAL PRIMARY KEY,
  business_id BIGINT UNSIGNED NOT NULL,
  name VARCHAR(50) NOT NULL,
  img BIGINT UNSIGNED NOT NULL,
  opening_time TIME NOT NULL DEFAULT "09:00:00",
  closing_time TIME NOT NULL DEFAULT "21:00:00",
  address BIGINT UNSIGNED NOT NULL,
  CONSTRAINT belongs_to_business FOREIGN KEY (business_id) REFERENCES businesses (id),
  CONSTRAINT shop_image FOREIGN KEY (img) REFERENCES images (id),
  CONSTRAINT shop_address FOREIGN KEY (address) REFERENCES addresses (id)
);

CREATE TABLE IF NOT EXISTS barbers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  img BIGINT UNSIGNED NOT NULL,
  shop BIGINT UNSIGNED NOT NULL NOT NULL,
  CONSTRAINT barber_in_shop FOREIGN KEY (shop) REFERENCES shops (id),
  CONSTRAINT barber_has_image FOREIGN KEY (img) REFERENCES images (id)
);

CREATE TABLE IF NOT EXISTS phones (
  phone_id BIGINT UNSIGNED NOT NULL,
  shop_id BIGINT UNSIGNED NOT NULL,
  value CHAR(10) NOT NULL,
  CONSTRAINT phones_in_shop FOREIGN KEY (shop_id) REFERENCES shops (id)
);

CREATE TABLE IF NOT EXISTS reservations (
  id SERIAL PRIMARY KEY,
  reservation_date DATE NOT NULL,
  reservation_time TIME NOT NULL,
  customer_id BIGINT UNSIGNED NOT NULL,
  is_validated BOOL NOT NULL DEFAULT false, 
  CONSTRAINT customer_reservation FOREIGN KEY (customer_id) REFERENCES customer (id)
);

CREATE TABLE IF NOT EXISTS shops_have_reservations (
  shop_id BIGINT UNSIGNED NOT NULL,
  reservation_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (shop_id, reservation_id),
  CONSTRAINT reservation_has_shop FOREIGN KEY (reservation_id) REFERENCES reservations (id),
  CONSTRAINT shop_has_reservations FOREIGN KEY (shop_id) REFERENCES shops (id)
);