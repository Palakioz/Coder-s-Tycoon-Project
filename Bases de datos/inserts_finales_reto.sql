USE neoris_prueba
GO

-- inserts de usuarios
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([id_usuario], [nombre_usuario], [e_mail], [ubicación], [departamento], [puesto], [es_admin], [contraseña], [eliminado], [foto_de_perfil]) VALUES (1, N'Mike_C', N'user1@tec.mx', N'Monterrey', N'IT', N'Admin', 1, N'0b14d501a594442a01c6859541bcb3e8164d183d32937b851835442f69d5c94e', 0, N'https://www.elitesingles.co.uk/wp-content/uploads/sites/59/2019/11/2b_en_articleslide_sm2-350x264.jpg')
INSERT [dbo].[Usuarios] ([id_usuario], [nombre_usuario], [e_mail], [ubicación], [departamento], [puesto], [es_admin], [contraseña], [eliminado], [foto_de_perfil]) VALUES (2, N'Guille_Téllez', N'user2@gmail.com', N'San Pedro', N'Web Apps', N'React Developer', 0, N'6cf615d5bcaac778352a8f1f3360d23f02f34ec182e259897fd6ce485d7870d4', 0, N'https://www.jaguarshoes.com/wp-content/uploads/2015/12/car-seat.jpg')
INSERT [dbo].[Usuarios] ([id_usuario], [nombre_usuario], [e_mail], [ubicación], [departamento], [puesto], [es_admin], [contraseña], [eliminado], [foto_de_perfil]) VALUES (3, N'Danny_C', N'user3@gmail.com', N'Monterrey', N'Databases', N'Cloud Developer', 0, N'5906ac361a137e2d286465cd6588ebb5ac3f5ae955001100bc41577c3d751764', 0, N'https://www.retratosbarcelona.com/wp-content/uploads/2022/09/Retratos-Barcelona-Linkedin-Photography-Alejandra.jpg')
INSERT [dbo].[Usuarios] ([id_usuario], [nombre_usuario], [e_mail], [ubicación], [departamento], [puesto], [es_admin], [contraseña], [eliminado], [foto_de_perfil]) VALUES (4, N'Nicolas_A', N'user4@tec.mx', N'McAllen', N'IT', N'Ciberseguridad', 0, N'b97873a40f73abedd8d685a7cd5e5f85e4a9cfb83eac26886640a0813850122b', 0, N'https://t4.ftcdn.net/jpg/00/18/00/23/360_F_18002378_CXA5wYveyH2qOmQo3AZmRdiZ79S3QM0T.jpg')
INSERT [dbo].[Usuarios] ([id_usuario], [nombre_usuario], [e_mail], [ubicación], [departamento], [puesto], [es_admin], [contraseña], [eliminado], [foto_de_perfil]) VALUES (5, N'Deborah_M', N'user5@gmail.com', N'Apodaca', N'Web Apps', N'Full stack Developer', 0, N'8b2c86ea9cf2ea4eb517fd1e06b74f399e7fec0fef92e3b482a6cf2e2b092023', 0, N'https://chicagophotovideo.com/wp-content/uploads/2017/10/ezgif.com-webp-to-jpg-14.jpg')
INSERT [dbo].[Usuarios] ([id_usuario], [nombre_usuario], [e_mail], [ubicación], [departamento], [puesto], [es_admin], [contraseña], [eliminado], [foto_de_perfil]) VALUES (6, N'Luis_Mi', N'user6@gmail.com', N'Guadalupe', N'App Development', N'Software Tester', 0, N'598a1a400c1dfdf36974e69d7e1bc98593f2e15015eed8e9b7e47a83b31693d5', 0, N'https://m.media-amazon.com/images/M/MV5BMTkzMTA1NTQ1OF5BMl5BanBnXkFtZTYwNTU0MDQz._V1_FMjpg_UX1000_.jpg')

SET IDENTITY_INSERT [dbo].[Usuarios] OFF

-- inserts de cursos
SET IDENTITY_INSERT [dbo].[Cursos] ON 

INSERT [dbo].[Cursos] ([id_curso], [nombre_curso], [estrellas_recompensa], [duración], [path_de_curso], [link_al_curso], [imagen]) VALUES (1, N'ChatGPT Prompt Engineering', 5, 10, N'Generative AI', N'https://www.udemy.com/course/chatgpt-prompt-engineering-for-beginners/?couponCode=LETSLEARNNOWPP', N'https://historiaglobalonline.com/wp-content/uploads/2023/06/cabecera.jpeg')
INSERT [dbo].[Cursos] ([id_curso], [nombre_curso], [estrellas_recompensa], [duración], [path_de_curso], [link_al_curso], [imagen]) VALUES (2, N'Gen AI Fundamentals', 4, 8, N'Generative AI', N'https://learn.microsoft.com/en-us/training/modules/fundamentals-generative-ai/', N'https://www.verdict.co.uk/wp-content/uploads/2023/06/shutterstock_2253228203.jpg')
INSERT [dbo].[Cursos] ([id_curso], [nombre_curso], [estrellas_recompensa], [duración], [path_de_curso], [link_al_curso], [imagen]) VALUES (3, N'GitHub Copilot', 3, 12, N'Generative AI', N'https://learn.microsoft.com/es-es/training/modules/introduction-to-github-copilot/', N'https://github.blog/wp-content/uploads/2023/03/GitHub-Copilot-X-Announcement.jpg?fit=3840%2C2160')
INSERT [dbo].[Cursos] ([id_curso], [nombre_curso], [estrellas_recompensa], [duración], [path_de_curso], [link_al_curso], [imagen]) VALUES (4, N'GitHub Advanced Security', 5, 8, N'Generative AI', N'https://learn.microsoft.com/en-us/training/modules/introduction-github-advanced-security/', N'https://github.blog/wp-content/uploads/2020/08/security-default.png?fit=1200%2C630')
INSERT [dbo].[Cursos] ([id_curso], [nombre_curso], [estrellas_recompensa], [duración], [path_de_curso], [link_al_curso], [imagen]) VALUES (5, N'Chat GPT for Python', 6, 5, N'Generative AI', N'https://www.udemy.com/course/chatgpt-python-integration/?couponCode=LETSLEARNNOWPP', N'https://i.blogs.es/1d8a5b/python1/450_1000.jpg')
SET IDENTITY_INSERT [dbo].[Cursos] OFF

-- 
SET IDENTITY_INSERT [dbo].[Progreso_Cursos] ON
GO
INSERT [dbo].[Progreso_Cursos] ([id_usuario], [id_curso], [porcentaje_progreso], [estrellas_reclamadas]) VALUES (2, 1, 75, 0)
INSERT [dbo].[Progreso_Cursos] ([id_usuario], [id_curso], [porcentaje_progreso], [estrellas_reclamadas]) VALUES (2, 2, 5, 0)
INSERT [dbo].[Progreso_Cursos] ([id_usuario], [id_curso], [porcentaje_progreso], [estrellas_reclamadas]) VALUES (2, 4, 50, 0)
INSERT [dbo].[Progreso_Cursos] ([id_usuario], [id_curso], [porcentaje_progreso], [estrellas_reclamadas]) VALUES (2, 5, 60, 0)
INSERT [dbo].[Progreso_Cursos] ([id_usuario], [id_curso], [porcentaje_progreso], [estrellas_reclamadas]) VALUES (3, 2, 15, 0)
INSERT [dbo].[Progreso_Cursos] ([id_usuario], [id_curso], [porcentaje_progreso], [estrellas_reclamadas]) VALUES (3, 3, 10, 0)
INSERT [dbo].[Progreso_Cursos] ([id_usuario], [id_curso], [porcentaje_progreso], [estrellas_reclamadas]) VALUES (3, 4, 20, 0)
GO
SET IDENTITY_INSERT [dbo].[Progreso_Cursos] OFF



SET IDENTITY_INSERT [dbo].[Logs] ON 

-- Usuario 2
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (1, 2, CAST(N'2024-04-27T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (2, 2, CAST(N'2024-04-27T14:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (3, 2, CAST(N'2024-04-28T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (4, 2, CAST(N'2024-04-28T16:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (5, 2, CAST(N'2024-04-29T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (6, 2, CAST(N'2024-04-29T17:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (7, 2, CAST(N'2024-04-30T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (8, 2, CAST(N'2024-04-30T12:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (9, 2, CAST(N'2024-05-1T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (10, 2, CAST(N'2024-05-1T13:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (11, 2, CAST(N'2024-05-2T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (12, 2, CAST(N'2024-05-2T11:00:00.0000000' AS DateTime2), N'desconexion')

-- Usuario 3
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (13, 3, CAST(N'2024-04-27T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (14, 3, CAST(N'2024-04-27T14:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (15, 3, CAST(N'2024-04-28T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (16, 3, CAST(N'2024-04-28T16:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (17, 3, CAST(N'2024-04-29T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (18, 3, CAST(N'2024-04-29T17:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (19, 3, CAST(N'2024-04-30T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (20, 3, CAST(N'2024-04-30T12:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (21, 3, CAST(N'2024-05-01T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (22, 3, CAST(N'2024-05-01T13:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (23, 3, CAST(N'2024-05-02T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (24, 3, CAST(N'2024-05-02T11:00:00.0000000' AS DateTime2), N'desconexion')

-- Usuario 4
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (25, 4, CAST(N'2024-04-27T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (26, 4, CAST(N'2024-04-27T14:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (27, 4, CAST(N'2024-04-28T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (28, 4, CAST(N'2024-04-28T16:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (29, 4, CAST(N'2024-04-29T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (30, 4, CAST(N'2024-04-29T17:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (31, 4, CAST(N'2024-04-30T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (32, 4, CAST(N'2024-04-30T12:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (33, 4, CAST(N'2024-05-01T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (34, 4, CAST(N'2024-05-01T13:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (35, 4, CAST(N'2024-05-02T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (36, 4, CAST(N'2024-05-02T13:00:00.0000000' AS DateTime2), N'desconexion')

-- Usuario 5
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (37, 5, CAST(N'2024-04-27T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (38, 5, CAST(N'2024-04-27T14:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (39, 5, CAST(N'2024-04-28T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (40, 5, CAST(N'2024-04-28T16:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (41, 5, CAST(N'2024-04-29T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (42, 5, CAST(N'2024-04-29T17:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (43, 5, CAST(N'2024-04-30T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (44, 5, CAST(N'2024-04-30T12:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (45, 5, CAST(N'2024-05-01T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (46, 5, CAST(N'2024-05-01T13:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (47, 5, CAST(N'2024-05-02T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (48, 5, CAST(N'2024-05-02T11:00:00.0000000' AS DateTime2), N'desconexion')

-- Usuario 6
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (49, 6, CAST(N'2024-04-27T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (50, 6, CAST(N'2024-04-27T14:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (51, 6, CAST(N'2024-04-28T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (52, 6, CAST(N'2024-04-28T16:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (53, 6, CAST(N'2024-04-29T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (54, 6, CAST(N'2024-04-29T17:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (55, 6, CAST(N'2024-04-30T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (56, 6, CAST(N'2024-04-30T12:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (57, 6, CAST(N'2024-05-01T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (58, 6, CAST(N'2024-05-01T13:00:00.0000000' AS DateTime2), N'desconexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (59, 6, CAST(N'2024-05-02T10:00:00.0000000' AS DateTime2), N'conexion')
INSERT [dbo].[Logs] ([id_log], [id_usuario], [fecha_log], [estado_de_conexion]) VALUES (60, 6, CAST(N'2024-05-02T11:00:00.0000000' AS DateTime2), N'desconexion')
SET IDENTITY_INSERT [dbo].[Logs] OFF