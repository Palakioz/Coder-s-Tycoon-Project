-- Creacion de todas las tablas
CREATE TABLE Usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre_usuario NVARCHAR(15) NOT NULL,
	contraseña NVARCHAR(64) NOT NULL,
    e_mail NVARCHAR(255) NOT NULL,
    ubicación NVARCHAR(30) NOT NULL,
    departamento NVARCHAR(30) NOT NULL,
    puesto NVARCHAR(30) NOT NULL,
    foto_de_perfil NVARCHAR(2083),
    es_admin BIT NOT NULL,
	eliminado BIT NOT NULL,
	cursos_favoritos NVARCHAR(MAX),
	CONSTRAINT AK_nombre_usuario UNIQUE(nombre_usuario),
	CONSTRAINT AK_e_mail UNIQUE(e_mail)
);

CREATE TABLE Datos_de_Juego (
    id_usuario INT,
    neo_stars INT NOT NULL,
    neo_coins INT NOT NULL,
    datos_guardado NVARCHAR(MAX) NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Estadisticas_Usuarios ( -- cambiar horas de juego a float
    id_usuario INT,
    minutos_de_juego FLOAT NOT NULL,
    fecha DATE NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Cursos (
    id_curso INT IDENTITY(1,1) PRIMARY KEY,
    nombre_curso NVARCHAR(50) NOT NULL,
    estrellas_recompensa INT NOT NULL,
    duración INT NOT NULL,
	path_de_curso NVARCHAR(50) NOT NULL,
    link_al_curso NVARCHAR(2083) NOT NULL,
	imagen NVARCHAR(2083) NOT NULL,
	CONSTRAINT AK_nombre_curso UNIQUE(nombre_curso),
	CONSTRAINT AK_link_al_curso UNIQUE(link_al_curso)
);

CREATE TABLE Progreso_Cursos (
    id_usuario INT NOT NULL,
    id_curso INT NOT NULL,
    porcentaje_progreso INT NOT NULL,
	estrellas_reclamadas BIT NOT NULL,
    PRIMARY KEY (id_usuario, id_curso),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

CREATE TABLE Logs (
    id_log INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_log DATETIME2 NOT NULL,
    estado_de_conexion NVARCHAR(11) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);
-------------------------------------------------------------------------------------------------------------------------------------------
-- WEB 

-- AUTENTICACION
-- Realizar verificación de usuario
GO
CREATE OR ALTER PROCEDURE verificar_usuario
@e_mail VARCHAR(255),
@contraseña NVARCHAR(64)AS
BEGIN
	IF (@contraseña) = (SELECT contraseña FROM Usuarios WHERE e_mail = @e_mail) AND (SELECT eliminado FROM Usuarios WHERE e_mail = @e_mail) = 0
	BEGIN
		SELECT id_usuario, nombre_usuario, e_mail, ubicación AS ubicacion, departamento, puesto, es_admin, foto_de_perfil, cursos_favoritos, CAST(1 AS BIT) AS validacion
		FROM Usuarios
		WHERE e_mail = @e_mail;
	END
	ELSE
	BEGIN
		SELECT CAST (0 AS BIT) AS validacion, CAST (0 AS BIT) AS es_admin
	END
END;

-- USUARIO
-- Conseguir promedio de avance en todos los cursos de un solo usuario.
GO
CREATE OR ALTER PROCEDURE promedio_avance
@id_usuario INT
AS
BEGIN
	SELECT AVG(porcentaje_progreso) AS porcentaje_promedio
	FROM Progreso_Cursos
	WHERE id_usuario = @id_usuario
END;

-- Conseguir lista de cursos para coursesCard
GO
CREATE OR ALTER PROCEDURE listado_cursos_web_card
@id_usuario INT
AS
BEGIN
	SELECT path_de_curso, nombre_curso, imagen, link_al_curso, Cursos.id_curso
	FROM Cursos
	JOIN Progreso_Cursos ON Progreso_Cursos.id_curso = Cursos.id_curso
	WHERE Progreso_Cursos.id_usuario = @id_usuario
	ORDER BY nombre_curso ASC;
END;

-- Conseguir info de la profileCard
GO
CREATE OR ALTER PROCEDURE profile_card
@id_usuario INT
AS
BEGIN
	SELECT neo_coins, neo_stars, COUNT(Progreso_Cursos.id_curso) AS cursos_inscritos
	FROM Usuarios
	JOIN Datos_de_Juego ON Datos_de_Juego.id_usuario = @id_usuario
	JOIN Progreso_Cursos ON Progreso_Cursos.id_usuario = @id_usuario
	WHERE Usuarios.id_usuario = @id_usuario
	GROUP BY  neo_coins, neo_stars
END;

-- Conseguir cursos inscritos para la pestaña de cursos
GO
CREATE OR ALTER PROCEDURE cursos_inscritos_usuario
@id_usuario INT
AS
BEGIN
	SELECT Cursos.id_curso, path_de_curso, nombre_curso, imagen, link_al_curso, duración AS duracion, porcentaje_progreso
	FROM Cursos
	LEFT JOIN Progreso_Cursos ON Cursos.id_curso = Progreso_Cursos.id_curso
	AND id_usuario = @id_usuario
END;

-- Actualizar progreso de un curso
GO 
CREATE OR ALTER PROCEDURE actualizar_progreso_curso
@id_usuario INT,
@id_curso INT,
@nuevo_porcentaje INT
AS
BEGIN
	UPDATE Progreso_Cursos
	SET porcentaje_progreso = @nuevo_porcentaje
	WHERE id_curso = @id_curso AND id_usuario = @id_usuario
END;

-- Inscribir a usuario al curso
GO 
CREATE OR ALTER PROCEDURE crear_progreso_curso
@id_usuario INT,
@id_curso INT,
@nuevo_porcentaje INT
AS
BEGIN
	INSERT INTO Progreso_Cursos (id_usuario, id_curso, porcentaje_progreso, estrellas_reclamadas)
	VALUES (@id_usuario, @id_curso, @nuevo_porcentaje, 0)
END;

-- Añadir un curso favorito
GO
CREATE OR ALTER PROCEDURE anadir_curso_favorito
    @id_usuario INT,
    @id_curso INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @FavoriteCourses NVARCHAR(MAX);

    SELECT @FavoriteCourses = ISNULL(cursos_favoritos, '')
    FROM Usuarios
    WHERE id_usuario = @id_usuario;

    IF @FavoriteCourses = ''
        SET @FavoriteCourses = CAST(@id_curso AS NVARCHAR(10));
    ELSE
        SET @FavoriteCourses = @FavoriteCourses + ' ' + CAST(@id_curso AS NVARCHAR(10));

    UPDATE Usuarios
    SET cursos_favoritos = @FavoriteCourses
    WHERE id_usuario = @id_usuario;

	SELECT cursos_favoritos
	FROM Usuarios
	WHERE id_usuario = @id_usuario
END;

-- Quitar un curso de favoritos
GO
CREATE OR ALTER PROCEDURE quitar_curso_favorito
    @id_usuario INT,
    @id_curso INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @FavoriteCourses NVARCHAR(MAX);

    SELECT @FavoriteCourses = ISNULL(cursos_favoritos, '')
    FROM Usuarios
    WHERE id_usuario = @id_usuario;

    SET @FavoriteCourses = REPLACE(' ' + @FavoriteCourses + ' ', ' ' + CAST(@id_curso AS NVARCHAR(10)) + ' ', ' ');

	SET @FavoriteCourses = LTRIM(RTRIM(@FavoriteCourses));

    UPDATE Usuarios
    SET cursos_favoritos = @FavoriteCourses
    WHERE id_usuario = @id_usuario;

	SELECT cursos_favoritos
	FROM Usuarios
	WHERE id_usuario = @id_usuario
END;

-- Conseguir listado de cursos favoritos de un usuario
GO
CREATE OR ALTER PROCEDURE favorite_courses
@id_usuario INT
AS
BEGIN
	SELECT cursos_favoritos
	FROM Usuarios
	WHERE id_usuario = @id_usuario
END;

-- ADMIN
-- Procedimiento para crear los datos de un nuevo usuario -- NO ESTA EN LA NUBE
GO 
CREATE OR ALTER PROCEDURE creacion_usuario 
@nombre_usuario VARCHAR(15), 
@e_mail NVARCHAR(255),
@contrasena NVARCHAR(64),
@ubicación NVARCHAR(30), 
@departamento NVARCHAR(30), 
@puesto NVARCHAR(30),
@foto_de_perfil NVARCHAR(2083),
@es_admin BIT
AS
BEGIN
	INSERT INTO Usuarios (nombre_usuario, contraseña, ubicación, e_mail, departamento, puesto, foto_de_perfil, es_admin, eliminado, cursos_favoritos)
	VALUES (@nombre_usuario, @contrasena,@ubicación, @e_mail, @departamento, @puesto, @foto_de_perfil, @es_admin, 0, '')
END;

select * from Usuarios;
exec creacion_usuario 'fid', 'f', '123','123', '123','222','aasd', 0;
-- Modificar los datos del usuario
GO
CREATE OR ALTER PROCEDURE modificar_usuario
    @id_usuario INT,
    @nombre_usuario NVARCHAR(15) = NULL,
    @e_mail NVARCHAR(255) = NULL,
    @ubicación NVARCHAR(30) = NULL,
    @departamento NVARCHAR(30) = NULL,
    @puesto NVARCHAR(30) = NULL,
    @foto_de_perfil NVARCHAR(2083) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar los datos del usuario solamente cuando los valores no sean iguales a los que ya estan en la base de datos y no sean NULL.
    UPDATE Usuarios
    SET
        nombre_usuario = CASE WHEN @nombre_usuario IS NOT NULL AND @nombre_usuario != nombre_usuario THEN @nombre_usuario ELSE nombre_usuario END,
        e_mail = CASE WHEN @e_mail IS NOT NULL AND @e_mail != e_mail THEN @e_mail ELSE e_mail END,
        ubicación = CASE WHEN @ubicación IS NOT NULL AND @ubicación != ubicación THEN @ubicación ELSE ubicación END,
        departamento = CASE WHEN @departamento IS NOT NULL AND @departamento != departamento THEN @departamento ELSE departamento END,
        puesto = CASE WHEN @puesto IS NOT NULL AND @puesto != puesto THEN @puesto ELSE puesto END,
        foto_de_perfil = CASE WHEN @foto_de_perfil IS NOT NULL AND @foto_de_perfil != foto_de_perfil THEN @foto_de_perfil ELSE foto_de_perfil END
    WHERE id_usuario = @id_usuario;
END;

-- Marcar un usuario como eliminado
Go 
CREATE OR ALTER PROCEDURE eliminar_usuario
	@id_usuario INT
AS
BEGIN
	SET NOCOUNT ON;
	    UPDATE Usuarios
    SET eliminado =	1
    WHERE id_usuario = @id_usuario;
END;

-- listar todos los usuarios no admins y no eliminados para poder modificarlos o eliminarlos
GO
CREATE OR ALTER PROCEDURE listar_usuarios
AS
BEGIN
	SELECT id_usuario, nombre_usuario, e_mail, ubicación AS ubicacion, departamento, puesto, foto_de_perfil FROM Usuarios
	WHERE es_admin = 0 AND eliminado = 0;

END;

-- Conseguir tráfico en los últimos 7 días
GO
CREATE OR ALTER PROCEDURE conexiones_por_fecha
AS
BEGIN
    SELECT TOP 7 CONVERT(DATE, fecha_log) AS log_date, COUNT(DISTINCT id_usuario) AS cantidad_visitas
    FROM Logs
    WHERE estado_de_conexion = 'conexion'
    GROUP BY CONVERT(DATE, fecha_log)
    ORDER BY log_date ASC
END;

-- Minutos promedio del juego por fecha
GO
CREATE OR ALTER PROCEDURE minutos_juego_por_fecha
AS
BEGIN
	SELECT 
		fecha AS fecha,
		AVG(minutos_de_juego) AS promedio_minutos_de_juego

		FROM Estadisticas_Usuarios

		GROUP BY fecha
	ORDER BY fecha ASC
END;

-- Conseguir promedio total de todos los cursos de todos los usuarios
GO
CREATE OR ALTER PROCEDURE promedio_total_progreso
AS
BEGIN
	SELECT AVG(porcentaje_progreso) AS promedio_porcentaje_avance_total FROM Progreso_Cursos
END;

-- Ver todos los usuarios no admins y no borrados
GO
CREATE OR ALTER PROCEDURE usuarios_no_admins
AS
BEGIN
	SELECT U.nombre_usuario, U.foto_de_perfil, L.fecha_log AS ultima_conexion, puesto
	FROM Usuarios U
	JOIN (
		SELECT id_usuario, MAX(fecha_log) AS max_fecha_log
		FROM Logs 
		GROUP BY id_usuario
	) MaxLogs ON U.id_usuario = MaxLogs.id_usuario
	JOIN Logs L ON MaxLogs.id_usuario = L.id_usuario AND MaxLogs.max_fecha_log = L.fecha_log
	WHERE U.es_admin = 0 AND U.eliminado = 0;
END;

-- Procedimeinto para utilziar los datos en una tabla donde se vean los cursos mas populares.
GO
CREATE OR ALTER PROCEDURE cursos_populares
AS
BEGIN
	SELECT 
		C.nombre_curso AS curso,
		COUNT(PC.id_usuario) AS usuarios_inscritos,
		AVG(porcentaje_progreso) AS porcentaje_progreso_promedio,
		imagen,
		SUM(CASE WHEN PC.porcentaje_progreso = 100 THEN 1 ELSE 0 END) AS cursos_completados
	FROM 
		Cursos C
	JOIN 
		Progreso_Cursos PC ON C.id_curso = PC.id_curso
	GROUP BY 
		C.nombre_curso, C.imagen;
END;

-------------------------------------------------------------------------------------------------------------------------------------------
-- UNITY

-- Actualizar datos de guardado
GO
CREATE OR ALTER PROCEDURE actualizar_datos_juego
@id_usuario INT,
@neo_stars INT,
@neo_coins INT,
@datos_guardado NVARCHAR(MAX)
AS
BEGIN
	UPDATE Datos_de_Juego
	SET neo_coins = @neo_coins, neo_stars = @neo_stars, datos_guardado = @datos_guardado
	WHERE id_usuario = @id_usuario
END;

-- Conseguir datos de guardado
GO
CREATE OR ALTER PROCEDURE conseguir_datos_juego
@id_usuario INT
AS
BEGIN
	SELECT datos_guardado
	FROM Datos_de_Juego
	WHERE id_usuario = @id_usuario
END;

-- Query para obtener leaderboard
GO
CREATE OR ALTER PROCEDURE datos_leaderboard
AS
BEGIN
	SELECT TOP 5 u.nombre_usuario, dj.neo_coins, dj.neo_stars, (dj.neo_coins + dj.neo_stars * 3) AS puntuacion
	FROM Usuarios u
	JOIN Datos_de_Juego dj ON u.id_usuario = dj.id_usuario
	ORDER BY puntuacion DESC
END;

-- Listar los cursos del usuario
GO
CREATE OR ALTER PROCEDURE listado_cursos_unity
@id_usuario INT
AS
BEGIN
	SELECT nombre_curso, estrellas_recompensa, porcentaje_progreso, estrellas_reclamadas
	FROM Cursos
	JOIN Progreso_Cursos
	ON Progreso_Cursos.id_curso = Cursos.id_curso
	WHERE id_usuario = @id_usuario;
END;

-- Crear log de conexión o desconexión
GO
CREATE OR ALTER PROCEDURE log_conexion
@id_usuario INT,
@tipo_conexion NVARCHAR(11)
AS
BEGIN
	INSERT INTO Logs(id_usuario, fecha_log, estado_de_conexion)
	VALUES (@id_usuario, GETDATE(), @tipo_conexion)
END;

-- Crear datos de guardado default para un nuevo usuario no admin
GO
CREATE OR ALTER TRIGGER nuevo_usuario
ON Usuarios
AFTER INSERT
AS
BEGIN
	IF (SELECT es_admin FROM inserted) = 0
		BEGIN
		INSERT INTO Datos_de_Juego (id_usuario, neo_stars, neo_coins, datos_guardado)
		VALUES 
		((SELECT id_usuario FROM inserted),0,0,'{"neoCoins":0.0,"autoClickValue":0.0,"clickPowerValue":1.0,"neoStars":0.0,"realAutoClickValue":0.0,"realClickPowerValue":0.0,"totalCoinsEarned":0.0,"totalStarsEaenred":0.0,"upgradeCostMouse":25,"upgradeIncrementMouse":1.0,"upgradeLevelMouse":0,"upgradeCostCriptoGranja":200,"upgradeIncrementCriptoGranja":1.0,"upgradeLevelCriptoGranja":0,"upgradeCostGPU":500,"upgradeIncrementGPU":10.0,"upgradeLevelGPU":0,"upgradeCostGPT":1500,"upgradeIncrementGPT":10.0,"upgradeLevelGPT":0,"upgradeLevelChair":0,"upgradeLevelMonitor":0}');
		END
END;

-- Actualizar estrellas reclamadas
GO
CREATE OR ALTER PROCEDURE UpdateEstrellasReclamadas
    @UserID INT,
    @CourseName NVARCHAR(50)
AS
BEGIN
    DECLARE @CourseID INT;
    SELECT @CourseID = id_curso
    FROM Cursos
    WHERE nombre_curso = @CourseName;
    UPDATE Progreso_Cursos
    SET estrellas_reclamadas = 1
    WHERE id_usuario = @UserID
    AND id_curso = @CourseID;
END;

-- Trigger para saber los minutos que se jugaron durante la sesión de juego, toma la hora de la conexion y desconexion para caluclar los minutos dentro del juego
GO
CREATE OR ALTER TRIGGER actualizar_horas_de_juego
ON Logs
AFTER INSERT
AS
BEGIN
	IF (SELECT estado_de_conexion FROM inserted) = 'desconexion'
	BEGIN
		DECLARE @fecha_log1 DATETIME2;
		DECLARE @fecha_log2 DATETIME2;
		DECLARE @diff_fecha_minutos FLOAT;
		DECLARE @id_usuario INT;
		DECLARE @ultimos_minutos FLOAT;

		SELECT @id_usuario = id_usuario FROM inserted;
		-- Se consigue la ultima fecha y hora en la que se realizó la última conexión
		SELECT TOP 1 @fecha_log1 = fecha_log 
		FROM Logs
		WHERE id_usuario = (@id_usuario) AND estado_de_conexion = 'conexion'
		ORDER BY fecha_log DESC;

		SELECT @fecha_log2 = fecha_log FROM inserted;

		SET @diff_fecha_minutos = DATEDIFF(MINUTE, @fecha_log1, @fecha_log2);

		IF EXISTS (SELECT * FROM Estadisticas_Usuarios WHERE id_usuario = @id_usuario AND CONVERT(DATE, fecha) = CONVERT(DATE, @fecha_log2))
			BEGIN
				SELECT @ultimos_minutos = minutos_de_juego 
				FROM Estadisticas_Usuarios 
				WHERE id_usuario = @id_usuario AND CONVERT(DATE, fecha) = CONVERT(DATE, @fecha_log2);

				UPDATE Estadisticas_Usuarios SET minutos_de_juego = @ultimos_minutos + @diff_fecha_minutos
				WHERE id_usuario = @id_usuario AND CONVERT(DATE, fecha) = CONVERT(DATE, @fecha_log2);
			END
		ELSE
			BEGIN
				INSERT INTO Estadisticas_Usuarios (id_usuario, minutos_de_juego, fecha) 
				VALUES ((SELECT id_usuario FROM inserted), @diff_fecha_minutos, @fecha_log2);
			END
	END
END;
