-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         11.3.0-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para pedidos
CREATE DATABASE IF NOT EXISTS `pedidos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `pedidos`;

-- Volcando estructura para tabla pedidos.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.auth_group: ~0 rows (aproximadamente)

-- Volcando estructura para tabla pedidos.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.auth_group_permissions: ~0 rows (aproximadamente)

-- Volcando estructura para tabla pedidos.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.auth_permission: ~36 rows (aproximadamente)
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 2, 'add_permission'),
	(6, 'Can change permission', 2, 'change_permission'),
	(7, 'Can delete permission', 2, 'delete_permission'),
	(8, 'Can view permission', 2, 'view_permission'),
	(9, 'Can add group', 3, 'add_group'),
	(10, 'Can change group', 3, 'change_group'),
	(11, 'Can delete group', 3, 'delete_group'),
	(12, 'Can view group', 3, 'view_group'),
	(13, 'Can add user', 4, 'add_user'),
	(14, 'Can change user', 4, 'change_user'),
	(15, 'Can delete user', 4, 'delete_user'),
	(16, 'Can view user', 4, 'view_user'),
	(17, 'Can add content type', 5, 'add_contenttype'),
	(18, 'Can change content type', 5, 'change_contenttype'),
	(19, 'Can delete content type', 5, 'delete_contenttype'),
	(20, 'Can view content type', 5, 'view_contenttype'),
	(21, 'Can add session', 6, 'add_session'),
	(22, 'Can change session', 6, 'change_session'),
	(23, 'Can delete session', 6, 'delete_session'),
	(24, 'Can view session', 6, 'view_session'),
	(25, 'Can add pedidos', 7, 'add_pedidos'),
	(26, 'Can change pedidos', 7, 'change_pedidos'),
	(27, 'Can delete pedidos', 7, 'delete_pedidos'),
	(28, 'Can view pedidos', 7, 'view_pedidos'),
	(29, 'Can add categoria', 8, 'add_categoria'),
	(30, 'Can change categoria', 8, 'change_categoria'),
	(31, 'Can delete categoria', 8, 'delete_categoria'),
	(32, 'Can view categoria', 8, 'view_categoria'),
	(33, 'Can add producto', 9, 'add_producto'),
	(34, 'Can change producto', 9, 'change_producto'),
	(35, 'Can delete producto', 9, 'delete_producto'),
	(36, 'Can view producto', 9, 'view_producto');

-- Volcando estructura para tabla pedidos.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.auth_user: ~1 rows (aproximadamente)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$600000$fSh58AEHOMFzGqmIEol6oK$qb1FBbz9u4u28zvCIUSgN7t+SstQ8eZQ36BnhwaCXYI=', '2025-03-05 16:31:59.782004', 1, 'operador', '', '', 'operador@mail.com', 1, 1, '2025-03-05 16:31:26.621423');

-- Volcando estructura para tabla pedidos.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.auth_user_groups: ~0 rows (aproximadamente)

-- Volcando estructura para tabla pedidos.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.auth_user_user_permissions: ~0 rows (aproximadamente)

-- Volcando estructura para tabla pedidos.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.django_admin_log: ~4 rows (aproximadamente)
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(1, '2025-03-05 16:35:34.820884', '1', 'Decorativos', 1, '[{"added": {}}]', 8, 1),
	(2, '2025-03-05 16:35:49.756683', '2', 'Eudérmicos', 1, '[{"added": {}}]', 8, 1),
	(3, '2025-03-05 16:37:43.712109', '1', 'Base L.A. Girl PRO.matte Bisque GLM672', 1, '[{"added": {}}]', 9, 1),
	(4, '2025-03-05 16:39:21.991474', '2', 'Delineador de ojos en gel delgado GEL661 L.A Girl', 1, '[{"added": {}}]', 9, 1),
	(5, '2025-03-05 17:49:30.084455', '3', 'GBL422 Rubor L.AGirl Blushed Babe', 1, '[{"added": {}}]', 9, 1);

-- Volcando estructura para tabla pedidos.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.django_content_type: ~9 rows (aproximadamente)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(5, 'contenttypes', 'contenttype'),
	(8, 'pedidos', 'categoria'),
	(7, 'pedidos', 'pedidos'),
	(9, 'pedidos', 'producto'),
	(6, 'sessions', 'session');

-- Volcando estructura para tabla pedidos.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.django_migrations: ~21 rows (aproximadamente)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2025-03-05 15:32:56.473565'),
	(2, 'auth', '0001_initial', '2025-03-05 15:32:56.604450'),
	(3, 'admin', '0001_initial', '2025-03-05 15:32:56.632837'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2025-03-05 15:32:56.635836'),
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-03-05 15:32:56.638836'),
	(6, 'contenttypes', '0002_remove_content_type_name', '2025-03-05 15:32:56.661724'),
	(7, 'auth', '0002_alter_permission_name_max_length', '2025-03-05 15:32:56.674727'),
	(8, 'auth', '0003_alter_user_email_max_length', '2025-03-05 15:32:56.682727'),
	(9, 'auth', '0004_alter_user_username_opts', '2025-03-05 15:32:56.685727'),
	(10, 'auth', '0005_alter_user_last_login_null', '2025-03-05 15:32:56.699504'),
	(11, 'auth', '0006_require_contenttypes_0002', '2025-03-05 15:32:56.700503'),
	(12, 'auth', '0007_alter_validators_add_error_messages', '2025-03-05 15:32:56.703966'),
	(13, 'auth', '0008_alter_user_username_max_length', '2025-03-05 15:32:56.711968'),
	(14, 'auth', '0009_alter_user_last_name_max_length', '2025-03-05 15:32:56.720137'),
	(15, 'auth', '0010_alter_group_name_max_length', '2025-03-05 15:32:56.728137'),
	(16, 'auth', '0011_update_proxy_permissions', '2025-03-05 15:32:56.731137'),
	(17, 'auth', '0012_alter_user_first_name_max_length', '2025-03-05 15:32:56.740137'),
	(18, 'pedidos', '0001_initial', '2025-03-05 15:32:56.745137'),
	(19, 'sessions', '0001_initial', '2025-03-05 15:32:56.757476'),
	(20, 'pedidos', '0002_categoria_producto', '2025-03-05 16:26:33.990762'),
	(21, 'pedidos', '0003_alter_producto_precio', '2025-03-05 17:21:27.395481');

-- Volcando estructura para tabla pedidos.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.django_session: ~1 rows (aproximadamente)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('r1i48wbr0qttk7y4hc8d9f4g8okjn2i3', '.eJxVjr0OwjAQg98lM4ry3wsjO88QpbkcLVQNatIJ8e60qAN4tD9bfrEQ1zaEteYljMjOTLLTr9fH9MjzHuA9zrfCU5nbMvZ8R_iRVn4tmKfLwf4NDLEOW9sZJDAgfJ-c8zoL1XUGrLYSrBJGkRdOK0qgHSbaZIAcJPKaOhuj2UanWFt4ZhyxfK9K-f4ATMI9_w:1tpvtw:jksSwFUHbiZnw-kk7zfbYPN6oCgS4Yl5e0psQQvXgcY', '2025-03-19 21:03:36.937541');

-- Volcando estructura para tabla pedidos.pedidos_categoria
CREATE TABLE IF NOT EXISTS `pedidos_categoria` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.pedidos_categoria: ~2 rows (aproximadamente)
INSERT INTO `pedidos_categoria` (`id`, `nombre`) VALUES
	(1, 'Decorativos'),
	(2, 'Eudérmicos');

-- Volcando estructura para tabla pedidos.pedidos_pedidos
CREATE TABLE IF NOT EXISTS `pedidos_pedidos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `direccion` longtext NOT NULL,
  `celular` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.pedidos_pedidos: ~7 rows (aproximadamente)
INSERT INTO `pedidos_pedidos` (`id`, `nombre`, `direccion`, `celular`) VALUES
	(1, 'Gonzalo Franco', 'Zona 1', '52901110'),
	(2, 'Gonzalo Franco', 'Zona 1', '52901110'),
	(3, 'Gabriel Maldonado', 'Zona 1', '4511100'),
	(4, 'Ariel', 'ZOna 2', '54451212'),
	(5, 'Adriana', 'Zona 10', '4552412'),
	(6, 'Betty', 'Zona 09', '454113213'),
	(7, 'Manuela Puac', 'Zona 7 calle A', '77712300'),
	(8, 'Ada', 'Zona 7 calle A', '47115154'),
	(9, 'Ada', 'Zona 7 calle A', '47115154'),
	(10, 'Ligia Perez', 'Zona 7 calle A 10-5', '47115150'),
	(11, 'Mayte Cottom', 'Zona 5 San Juan Ostuncaclco', '45454001');

-- Volcando estructura para tabla pedidos.pedidos_producto
CREATE TABLE IF NOT EXISTS `pedidos_producto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `descripcion` longtext NOT NULL,
  `imagen` varchar(100) NOT NULL,
  `categoria_id` bigint(20) DEFAULT NULL,
  `pedido_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`) USING BTREE,
  KEY `pedidos_producto_categoria_id_fd60851a_fk_pedidos_categoria_id` (`categoria_id`),
  KEY `pedidos_producto_pedido_id_8b8eeba1_fk_pedidos_pedidos_id` (`pedido_id`),
  CONSTRAINT `pedidos_producto_categoria_id_fd60851a_fk_pedidos_categoria_id` FOREIGN KEY (`categoria_id`) REFERENCES `pedidos_categoria` (`id`),
  CONSTRAINT `pedidos_producto_pedido_id_8b8eeba1_fk_pedidos_pedidos_id` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos_pedidos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla pedidos.pedidos_producto: ~2 rows (aproximadamente)
INSERT INTO `pedidos_producto` (`id`, `nombre`, `codigo`, `precio`, `descripcion`, `imagen`, `categoria_id`, `pedido_id`) VALUES
	(1, 'Base L.A. Girl PRO.matte Bisque GLM672', '0081555966720', 65.00, 'Ponte mate, venga. L.A. Girl PRO.matte Foundation es tu nuevo viaje o muere para lucir un rostro impecable y un uso duradero. Con un acabado sin brillo y similar a la gamuza, tendrás una cobertura suave y edificable que se verá mate, pero nunca seca. \r\nEsta base no solo minimiza la apariencia de los poros y las líneas finas con la fórmula de enfoque suave, sino que también contiene vitamina E, B5 y aceite de girasol para dejar la piel suave e hidratada. \r\n✨Cobertura media a completa \r\n✨Acabado similar al ante Cobertura edificable de larga duración \r\n✨Vitamina E, B5 y aceite de girasol añadidos \r\n✨Ideal para pieles normales a grasas \r\n✨Sin crueldad animal, sin parabenos y vegano Utilice el pigmento mezclador de base PRO.color para personalizar su tono y lograr una combinación perfecta.', 'productos/C48AE40E-977E-4A63-9498-2B4D57695353.jpg', 1, 7),
	(2, 'Delineador de ojos en gel delgado GEL661 L.A Girl', '0081555226619', 45.00, 'Un delineador de gel resistente a las manchas y de larga duración.\r\nMicropunta fina para crear delineadores ajustados\r\nFórmula resistente al agua y de larga duración.\r\nFormulado con aguacate, manteca de karité y vitamina E.\r\nSin crueldad, sin parabenos y vegano.', 'productos/6F4405E2-F96F-4384-A0EF-34DA80F8C484.jpg', 2, 11),
	(3, 'GBL422 Rubor L.AGirl Blushed Babe', 'Beauty', 72.00, 'paletas de rubores de 4 componentes en una gama de colores atrevidos que te dejarán sonrojado. Blushed Babe te hará sentir bonita en rosa o elige Island Hottie si lo tuyo son los corales cálidos. ¡Incluso puedes mezclar y combinar tonos para crear tu propia apariencia personalizada! El elegante estuche compacto y el espejo de tamaño completo', 'productos/DF69EBD3-7F13-44D9-B171-0E605FD8E6E2.jpg', 2, 11);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
