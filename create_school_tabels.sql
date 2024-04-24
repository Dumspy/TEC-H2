-- Create table Elev
CREATE TABLE Elev (
  elevid INT PRIMARY KEY,
  fornavn NVARCHAR(255) NOT NULL,
  efternavn NVARCHAR(255) NOT NULL,
  adresse NVARCHAR(255) NOT NULL,
  postnr INT,
  klasseid INT,
  FOREIGN KEY (postnr) REFERENCES PostNrBy(postnr),
  FOREIGN KEY (klasseid) REFERENCES Klasse(klasseid)
);

-- Create table Laerer
CREATE TABLE Laerer (
  laererid INT PRIMARY KEY,
  fornavn NVARCHAR(255) NOT NULL,
  efternavn NVARCHAR(255) NOT NULL,
  adresse NVARCHAR(255) NOT NULL,
  postnr INT,
  FOREIGN KEY (postnr) REFERENCES PostNrBy(postnr),
);

-- Create table Klasse
CREATE TABLE Klasse (
  klasseid INT PRIMARY KEY,
  klassenavn NVARCHAR(255) NOT NULL
);

-- Create table PostNrBy
CREATE TABLE PostNrBy (
  postnr INT PRIMARY KEY,
  bynavn NVARCHAR(255) NOT NULL
);

CREATE TABLE Underviser (
  laererid INT,
  klasseid INT,
  FOREIGN KEY (laererid) REFERENCES Laerer(laererid),
  FOREIGN KEY (klasseid) REFERENCES Klasse(klasseid),
  PRIMARY KEY (laererid, klasseid)
);
