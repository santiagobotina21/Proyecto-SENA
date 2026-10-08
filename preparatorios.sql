-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: preparatorios
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actas_preparatorios`
--

DROP TABLE IF EXISTS `actas_preparatorios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actas_preparatorios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nro_acta` int DEFAULT NULL,
  `id_secretaria` int DEFAULT NULL,
  `id_docente` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `id_estudiante` int DEFAULT NULL,
  `id_asignacion_academica` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_acta_docente` (`id_docente`),
  KEY `fk_acta_estudiante` (`id_estudiante`),
  CONSTRAINT `fk_acta_docente` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id`),
  CONSTRAINT `fk_acta_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actas_preparatorios`
--

LOCK TABLES `actas_preparatorios` WRITE;
/*!40000 ALTER TABLE `actas_preparatorios` DISABLE KEYS */;
/*!40000 ALTER TABLE `actas_preparatorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracion_preparatorios`
--

DROP TABLE IF EXISTS `configuracion_preparatorios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuracion_preparatorios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_preparatorio` int NOT NULL,
  `fecha_inicio_inscripciones` date DEFAULT NULL,
  `fecha_fin_inscripciones` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `id_asignacion_academica` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_configuracion_preparatorio` (`id_preparatorio`),
  CONSTRAINT `fk_configuracion_preparatorio` FOREIGN KEY (`id_preparatorio`) REFERENCES `preparatorios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracion_preparatorios`
--

LOCK TABLES `configuracion_preparatorios` WRITE;
/*!40000 ALTER TABLE `configuracion_preparatorios` DISABLE KEYS */;
/*!40000 ALTER TABLE `configuracion_preparatorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docentes`
--

DROP TABLE IF EXISTS `docentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docentes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_persona` int NOT NULL,
  `id_vinculacion` int DEFAULT NULL,
  `id_programa` int DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `dias_prueba` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nuevo` tinyint(1) DEFAULT '0',
  `id_escalafon` int DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_docente_persona` (`id_persona`),
  CONSTRAINT `fk_docente_persona` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docentes`
--

LOCK TABLES `docentes` WRITE;
/*!40000 ALTER TABLE `docentes` DISABLE KEYS */;
/*!40000 ALTER TABLE `docentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados_estudiantes`
--

DROP TABLE IF EXISTS `estados_estudiantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados_estudiantes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados_estudiantes`
--

LOCK TABLES `estados_estudiantes` WRITE;
/*!40000 ALTER TABLE `estados_estudiantes` DISABLE KEYS */;
/*!40000 ALTER TABLE `estados_estudiantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiantes`
--

DROP TABLE IF EXISTS `estudiantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiantes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_persona` int NOT NULL,
  `codigo` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_programa` int DEFAULT NULL,
  `id_semestre` int DEFAULT NULL,
  `id_estado_estudiante` int DEFAULT NULL,
  `semestre_asignado` tinyint(1) DEFAULT '0',
  `activo` tinyint(1) DEFAULT '1',
  `id_inscripcion` int DEFAULT NULL,
  `id_zeus_inscripcion` int DEFAULT NULL,
  `activar_pazysalvo` tinyint(1) DEFAULT '0',
  `aspirante_grado` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_estudiante_estado` (`id_estado_estudiante`),
  KEY `fk_estudiante_persona` (`id_persona`),
  CONSTRAINT `fk_estudiante_estado` FOREIGN KEY (`id_estado_estudiante`) REFERENCES `estados_estudiantes` (`id`),
  CONSTRAINT `fk_estudiante_persona` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantes`
--

LOCK TABLES `estudiantes` WRITE;
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
/*!40000 ALTER TABLE `estudiantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscripciones_preparatorios`
--

DROP TABLE IF EXISTS `inscripciones_preparatorios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscripciones_preparatorios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_preparatorio` int NOT NULL,
  `id_estudiante` int NOT NULL,
  `fecha_inscripcion` date DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `consecutivo_recibo` int DEFAULT NULL,
  `factura_pagado` tinyint(1) DEFAULT '0',
  `valor_pagado` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_inscripcion_estudiante` (`id_estudiante`),
  KEY `fk_inscripcion_preparatorio` (`id_preparatorio`),
  CONSTRAINT `fk_inscripcion_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id`),
  CONSTRAINT `fk_inscripcion_preparatorio` FOREIGN KEY (`id_preparatorio`) REFERENCES `preparatorios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscripciones_preparatorios`
--

LOCK TABLES `inscripciones_preparatorios` WRITE;
/*!40000 ALTER TABLE `inscripciones_preparatorios` DISABLE KEYS */;
/*!40000 ALTER TABLE `inscripciones_preparatorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matriculas`
--

DROP TABLE IF EXISTS `matriculas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matriculas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `fecha_matricula` date DEFAULT NULL,
  `id_periodo_academico` int DEFAULT NULL,
  `confirmacion` tinyint(1) DEFAULT '0',
  `fecha_actualizacion` date DEFAULT NULL,
  `fecha_cancelacion` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `observaciones` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_matricula_estudiante` (`id_estudiante`),
  KEY `fk_matricula_periodo` (`id_periodo_academico`),
  CONSTRAINT `fk_matricula_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id`),
  CONSTRAINT `fk_matricula_periodo` FOREIGN KEY (`id_periodo_academico`) REFERENCES `periodos_academicos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matriculas`
--

LOCK TABLES `matriculas` WRITE;
/*!40000 ALTER TABLE `matriculas` DISABLE KEYS */;
/*!40000 ALTER TABLE `matriculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas_generales`
--

DROP TABLE IF EXISTS `notas_generales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas_generales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `semestre` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valor_nota` decimal(5,2) DEFAULT NULL,
  `periodo_academico` int DEFAULT NULL,
  `asignacion_academica` int DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_nota_general_estudiante` (`id_estudiante`),
  KEY `fk_nota_general_periodo` (`periodo_academico`),
  CONSTRAINT `fk_nota_general_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id`),
  CONSTRAINT `fk_nota_general_periodo` FOREIGN KEY (`periodo_academico`) REFERENCES `periodos_academicos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas_generales`
--

LOCK TABLES `notas_generales` WRITE;
/*!40000 ALTER TABLE `notas_generales` DISABLE KEYS */;
/*!40000 ALTER TABLE `notas_generales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas_preparatorios`
--

DROP TABLE IF EXISTS `notas_preparatorios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas_preparatorios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nota_general_id` int DEFAULT NULL,
  `id_inscripcion_preparatorio` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_nota_inscripcion` (`id_inscripcion_preparatorio`),
  CONSTRAINT `fk_nota_inscripcion` FOREIGN KEY (`id_inscripcion_preparatorio`) REFERENCES `inscripciones_preparatorios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas_preparatorios`
--

LOCK TABLES `notas_preparatorios` WRITE;
/*!40000 ALTER TABLE `notas_preparatorios` DISABLE KEYS */;
/*!40000 ALTER TABLE `notas_preparatorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `novedades_preparatorios`
--

DROP TABLE IF EXISTS `novedades_preparatorios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `novedades_preparatorios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_plan_estudios` int DEFAULT NULL,
  `id_docente` int DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `periodo_academico` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_novedad_docente` (`id_docente`),
  KEY `fk_novedad_periodo` (`periodo_academico`),
  CONSTRAINT `fk_novedad_docente` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id`),
  CONSTRAINT `fk_novedad_periodo` FOREIGN KEY (`periodo_academico`) REFERENCES `periodos_academicos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `novedades_preparatorios`
--

LOCK TABLES `novedades_preparatorios` WRITE;
/*!40000 ALTER TABLE `novedades_preparatorios` DISABLE KEYS */;
/*!40000 ALTER TABLE `novedades_preparatorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodos_academicos`
--

DROP TABLE IF EXISTS `periodos_academicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `periodos_academicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `anio` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `periodo` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `actual` tinyint(1) DEFAULT '0',
  `id_tipo_periodo` int DEFAULT NULL,
  `estado` int DEFAULT NULL,
  `fecha_egreso` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodos_academicos`
--

LOCK TABLES `periodos_academicos` WRITE;
/*!40000 ALTER TABLE `periodos_academicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `periodos_academicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_identificacion` int DEFAULT NULL,
  `numero_identificacion` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `primer_nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `segundo_nombre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primer_apellido` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `segundo_apellido` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `datos_adicionales` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preparatorios`
--

DROP TABLE IF EXISTS `preparatorios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preparatorios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `valor_pago` int DEFAULT NULL,
  `fecha_evaluacion` datetime DEFAULT NULL,
  `lugar_evaluacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `valor_pagado` decimal(12,2) DEFAULT NULL,
  `id_tipo_evaluacion` int DEFAULT NULL,
  `limite_inscritos` int DEFAULT NULL,
  `fecha_limite_pago` date DEFAULT NULL,
  `mostrar_recibo` tinyint(1) DEFAULT '0',
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acuerdo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preparatorios`
--

LOCK TABLES `preparatorios` WRITE;
/*!40000 ALTER TABLE `preparatorios` DISABLE KEYS */;
INSERT INTO `preparatorios` VALUES (1,156000,'2026-11-01 08:00:00','AULA 3',1,NULL,NULL,30,'2026-10-15',0,'PREPARATORIO AREA PENAL','0011416Ç'),(2,320000,'2026-12-05 18:00:00','AULA 2',1,NULL,NULL,40,'2026-10-20',0,'PREPARATORIO AREA LABORAL','00151417'),(3,1233000,'2026-10-23 18:00:00','SALA BEYINA',1,NULL,NULL,5,'2026-10-15',0,'PREPARATORIO AREA PRIVADO','00141817'),(4,156000,'2026-10-31 08:00:00','AULA 1',1,NULL,NULL,45,'2026-10-13',0,'PREPARATORIO AREA PUBLICO','00181819');
/*!40000 ALTER TABLE `preparatorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sesiones`
--

DROP TABLE IF EXISTS `sesiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sesiones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha_hora_ingreso` datetime DEFAULT NULL,
  `direccion_ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aplicacion` int DEFAULT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sesion_usuario` (`id_usuario`),
  CONSTRAINT `fk_sesion_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesiones`
--

LOCK TABLES `sesiones` WRITE;
/*!40000 ALTER TABLE `sesiones` DISABLE KEYS */;
/*!40000 ALTER TABLE `sesiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_persona` int NOT NULL,
  `nombre_usuario` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clave_acceso` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` date DEFAULT (curdate()),
  PRIMARY KEY (`id`),
  KEY `fk_usuario_persona` (`id_persona`),
  CONSTRAINT `fk_usuario_persona` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-08 11:06:49
