SELECT Titel, Instruktør
FROM Film
WHERE Instruktør LIKE 'B%';
GO

SELECT f.Titel, g.navn AS Genre
FROM Film f
JOIN Genre g ON f.Genre = g.id;
GO

SELECT Titel, Playtime
FROM Film
WHERE Playtime > 120;
GO

SELECT Titel, Dato
FROM Film
WHERE Dato = (SELECT MIN(Dato) FROM Film);
GO
