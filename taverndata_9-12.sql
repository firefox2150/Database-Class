DROP TABLE IF EXISTS Taverns;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Shipments;
DROP TABLE IF EXISTS TavernServices;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS GuestLevels;
DROP TABLE IF EXISTS SupplySales;
DROP TABLE IF EXISTS Guests;
DROP TABLE IF EXISTS GuestStatus;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS BasementRats;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS ServiceStatus;

CREATE TABLE Taverns (
Id int IDENTITY, 
TavernName varchar(250), 
LocationId int, 
OwnerId int, 
Floors tinyint);

CREATE TABLE Users (
Id int IDENTITY, 
Name varchar(250), 
RoleId int);

CREATE TABLE Location (
Id int IDENTITY PRIMARY KEY, 
Name varchar(100));

CREATE TABLE Roles (
Id tinyint IDENTITY PRIMARY KEY, 
Name varchar(50), 
Description varchar(MAX));

/* CREATE TABLE BasementRats (Id int IDENTITY PRIMARY KEY, Name varchar(100));
Table has been deprecated. */

CREATE TABLE Supplies (
Id int IDENTITY PRIMARY KEY, 
Name varchar(150), 
Unit varchar(50));

CREATE TABLE Inventory (
Id int IDENTITY PRIMARY KEY, 
SupplyId int FOREIGN KEY REFERENCES Supplies(Id), 
TavernId int FOREIGN KEY REFERENCES Tavern(Id), 
LastUpdated date, 
Amount decimal);

CREATE TABLE Shipments (
Id int IDENTITY PRIMARY KEY, 
SupplyId int FOREIGN KEY REFERENCES Supplies(Id), 
TavernId int FOREIGN KEY REFERENCES Tavern(Id), 
Cost decimal, 
Amount decimal, 
ReceivedDate date);

CREATE TABLE Services (
Id int IDENTITY PRIMARY KEY, 
Name varchar(150));

CREATE TABLE ServiceStatus (
Id int IDENTITY PRIMARY KEY, 
Status varchar(100));

CREATE TABLE TavernServices (
Id int IDENTITY PRIMARY KEY, 
TavernId int FOREIGN KEY REFERENCES Tavern(Id), 
ServiceId int FOREIGN KEY REFERENCES Services(Id), 
StatusId int);

CREATE TABLE GuestStatus (
Id int IDENTITY PRIMARY KEY,
Status varchar (150));

CREATE TABLE Guests (
Id int IDENTITY PRIMARY KEY,
Name varchar(250)
Notes varchar(MAX),
Birthday date,
Cakeday date,
StatusId int FOREIGN KEY REFERENCES GuestStatus(Id));

CREATE TABLE Sales (
Id int IDENTITY PRIMARY KEY,
TavernId int FOREIGN KEY REFERENCES Tavern(Id), 
ServiceId int FOREIGN KEY REFERENCES Services(Id), 
GuestId int FOREIGN KEY REFERENCES Guests(Id), 
Price decimal, 
SaleTime datetime, 
Amount decimal);

CREATE TABLE SupplySales (
Id int IDENTITY PRIMARY KEY,
TavernId int FOREIGN KEY REFERENCES Tavern(Id),
SupplyId int FOREIGN KEY REFERENCES Supplies(Id),
GuestId int FOREIGN KEY REFERENCES Guests(Id), 
Price decimal, 
SaleTime datetime, 
Amount decimal);

CREATE TABLE Classes (
Id int IDENTITY PRIMARY KEY,
Name varchar(150));

CREATE TABLE GuestLevels (
Id int IDENTITY PRIMARY KEY,
GuestId int FOREIGN KEY REFERENCES Guests(Id),
ClassId int FOREIGN KEY REFERENCES Classes(Id),
ClassLevel int);

ALTER TABLE Tavern
ADD PRIMARY KEY (Id);

ALTER TABLE Tavern
ADD FOREIGN KEY (LocationId) REFERENCES Location(Id);

ALTER TABLE Tavern
ADD FOREIGN KEY (OwnerId) REFERENCES Users(Id);

ALTER TABLE Users
ADD PRIMARY KEY (Id);

ALTER TABLE Users
ADD FOREIGN KEY (RoleId) REFERENCES Roles(Id);

INSERT INTO Roles (Name, Description) VALUES ('Adventurer', 'Travels far and wide to find new and interesting alcohol and monsters.');
INSERT INTO Roles (Name, Description) VALUES ('Cleaner', 'Keeps their tavern neat and tidy.');
INSERT INTO Roles (Name, Description) VALUES ('Heavy', 'Encourages brawls in the tavern, especially when they are involved.');
INSERT INTO Roles (Name, Description) VALUES ('Bard', 'Always has live entertainment in his tavern, even if they have to be the one to supply it.');
INSERT INTO Roles (Name, Description) VALUES ('Connoisseur', 'Only serves the best food and drink in their establishment.');
INSERT INTO Location (Name) VALUES ('Rillanon');
INSERT INTO Location (Name) VALUES ('Gondor');
INSERT INTO Location (Name) VALUES ('Las Vegas');
INSERT INTO Location (Name) VALUES ('Altea');
INSERT INTO Location (Name) VALUES ('Philadelphia');
INSERT INTO Users (Name, RoleId) VALUES ('Robert Baratheon', 3);
INSERT INTO Users (Name, RoleId) VALUES ('Gordon Ramsey', 5);
INSERT INTO Users (Name, RoleId) VALUES ('Sam Winchester', 1);
INSERT INTO Users (Name, RoleId) VALUES ('Dean Winchester', 3);
INSERT INTO Users (Name, RoleId) VALUES ('Arutha conDoin', 1);
INSERT INTO Taverns (TavernName, LocationId, OwnerId, Floors) VALUES ('Artisenal Ales', 1, 5, 2);
INSERT INTO Taverns (TavernName, LocationId, OwnerId, Floors) VALUES ('Bold Beers', 3, 1, 3);
INSERT INTO Taverns (TavernName, LocationId, OwnerId, Floors) VALUES ('The Winchester' 4, 3, 1);
INSERT INTO Taverns (TavernName, LocationId, OwnerId, Floors) VALUES ('The Better Winchester', 2, 4, 2);
INSERT INTO Taverns (TavernName, LocationId, OwnerId, Floors) VALUES ('Lamb Sauce Lodge', 5, 2, 4);

/* BasementRats table has been deprecated.
INSERT INTO BasementRats (Name) VALUES ('Rattigan');
INSERT INTO BasementRats (Name) VALUES ('Cheesy');
INSERT INTO BasementRats (Name) VALUES ('Samuel');
INSERT INTO BasementRats (Name) VALUES ('John');
INSERT INTO BasementRats (Name) VALUES ('Frank');
*/

INSERT INTO Supplies (Name, Unit) VALUES ('Athenian Ale', 'Ounce');
INSERT INTO Supplies (Name, Unit) VALUES ('Brew of Bartholemew', 'Barrel');
INSERT INTO Supplies (Name, Unit) VALUES ('Peanuts', 'Pound');
INSERT INTO Supplies (Name, Unit) VALUES ('Pretzels', 'Bag');
INSERT INTO Supplies (Name, Unit) VALUES ('Sizzling Sweets', 'Piece');
INSERT INTO Inventory (SupplyId, TavernId, LastUpdated, Amount) VALUES (1, 1, 1998-10-05, 1200);
INSERT INTO Inventory (SupplyId, TavernId, LastUpdated, Amount) VALUES (1, 2, 1998-10-05, 1200);
INSERT INTO Inventory (SupplyId, TavernId, LastUpdated, Amount) VALUES (2, 3, 2000-05-07, 20);
INSERT INTO Inventory (SupplyId, TavernId, LastUpdated, Amount) VALUES (5, 5, 2010-06-06, 5000);
INSERT INTO Inventory (SupplyId, TavernId, LastUpdated, Amount) VALUES (4, 4, 2008-02-08, 200);
INSERT INTO Shipments (SupplyId, TavernId, Cost, Amount, ReceivedDate) VALUES (1, 1, 1998-10-05, 500);
INSERT INTO Shipments (SupplyId, TavernId, Cost, Amount, ReceivedDate) VALUES (1, 2, 1998-10-01, 200);
INSERT INTO Shipments (SupplyId, TavernId, Cost, Amount, ReceivedDate) VALUES (2, 3, 1999-05-05, 5);
INSERT INTO Shipments (SupplyId, TavernId, Cost, Amount, ReceivedDate) VALUES (5, 5, 2010-06-01, 1000);
INSERT INTO Shipments (SupplyId, TavernId, Cost, Amount, ReceivedDate) VALUES (4, 4, 2008-01-02, 50);
INSERT INTO Services (Name) VALUES ('Inn Room');
INSERT INTO Services (Name) VALUES ('Darts');
INSERT INTO Services (Name) VALUES ('Armor Repair');
INSERT INTO Services (Name) VALUES ('Target Practice');
INSERT INTO Services (Name) VALUES ('Exorcism');
INSERT INTO ServiceStatus (Status) VALUES ('Active');
INSERT INTO ServiceStatus (Status) VALUES ('Unavailable');
INSERT INTO ServiceStatus (Status) VALUES ('In Progress');
INSERT INTO ServiceStatus (Status) VALUES ('Out of Order');
INSERT INTO ServiceStatus (Status) VALUES ('Unknown');
INSERT INTO TavernServices (TavernId, ServiceId, StatusId) VALUES (3, 5, 3);
INSERT INTO TavernServices (TavernId, ServiceId, StatusId) VALUES (4, 5, 3);
INSERT INTO TavernServices (TavernId, ServiceId, StatusId) VALUES (1, 1, 1);
INSERT INTO TavernServices (TavernId, ServiceId, StatusId) VALUES (2, 3, 1);
INSERT INTO TavernServices (TavernId, ServiceId, StatusId) VALUES (1, 4, 2);
INSERT INTO GuestStatus (Status) VALUES ('Curmudgeonly');
INSERT INTO GuestStatus (Status) VALUES ('Hungry');
INSERT INTO GuestStatus (Status) VALUES ('Alarmed');
INSERT INTO GuestStatus (Status) VALUES ('Satisfied');
INSERT INTO GuestStatus (Status) VALUES ('Sleepy');
INSERT INTO Guests (Name, Notes, Birthday, Cakeday, StatusId) VALUES ('Frank', 'Loves his beer', 1988-01-05, 2000-05-11, 5);
INSERT INTO Guests (Name, Notes, Birthday, Cakeday, StatusId) VALUES ('Asmodeus', 'Does not like Gabriel very much', 1900-10-20, 2010-01-15, 1);
INSERT INTO Guests (Name, Notes, Birthday, Cakeday, StatusId) VALUES ('Gabriel', 'Has a bit of a glow to him', 1900-10-20, 2007-11-11, 3);
INSERT INTO Guests (Name, Notes, Birthday, Cakeday, StatusId) VALUES ('Legolas', 'Light on his feet', 1958-06-29, 2014-08-21, 4);
INSERT INTO Guests (Name, Notes, Birthday, Cakeday, StatusId) VALUES ('Sasquatch', 'Keeps to himself', 1930-09-01, 2011-02-28, 5);
INSERT INTO Sales (TavernId, ServiceId, GuestId, Price, SaleTime, Amount) VALUES (1, 1, 1, 5, 2018-09-08 20:05:12, 1);
INSERT INTO Sales (TavernId, ServiceId, GuestId, Price, SaleTime, Amount) VALUES (3, 5, 2, 100000, 2019-09-11 23:29:05, 1);
INSERT INTO Sales (TavernId, ServiceId, GuestId, Price, SaleTime, Amount) VALUES (4, 5, 3, 20000, 2019-09-10 03:03:03, 1);
INSERT INTO Sales (TavernId, ServiceId, GuestId, Price, SaleTime, Amount) VALUES (2, 3, 4, 1023, 2000-05-19 20:06:53, 2);
INSERT INTO Sales (TavernId, ServiceId, GuestId, Price, SaleTime, Amount) VALUES (1, 1, 5, 20, 1987-03-01 22:11:07, 1);

/* Due to some personal issues this weekend, I was unable to finish filling out data for all of the tables.
I will be doing this for the next assignment.*/

/* Insert statements that will fail due to constraints:

INSERT INTO Sales (TavernId, ServiceId, GuestName, Price, SaleTime, Amount) VALUES (20, 1, 'Pippin', 3, 2019-09-01 21:30:25, 1);
INSERT INTO Users (Name, RoleID) VALUES ('Merry', 50);
INSERT INTO Taverns (TavernName, LocationId, OwnerId, Floors) VALUES ('Lothlorian Lagers', 1, 23, 10);
INSERT INTO Inventory (SupplyId, TavernId, LastUpdated, Amount) VALUES (15, 3, 2000-05-07, 20);
INSERT INTO Inventory (SupplyId, TavernId, LastUpdated, Amount) VALUES (2, 35, 2000-05-07, 20);
INSERT INTO Shipments (SupplyId, TavernId, Cost, Amount, ReceivedDate) VALUES (87, 1, 1998-10-05, 500);
INSERT INTO Shipments (SupplyId, TavernId, Cost, Amount, ReceivedDate) VALUES (1, 19, 1998-10-05, 500);
INSERT INTO TavernServices (TavernId, ServiceId, StatusId) VALUES (42, 1, 1);
INSERT INTO TavernServices (TavernId, ServiceId, StatusId) VALUES (1, 108, 1);
INSERT INTO TavernServices (TavernId, ServiceId, StatusId) VALUES (1, 1, 21);
INSERT INTO Sales (TavernId, ServiceId, GuestId, Price, SaleTime, Amount) VALUES (54, 5, 3, 20000, 2019-09-10 03:03:03, 1);
INSERT INTO Sales (TavernId, ServiceId, GuestId, Price, SaleTime, Amount) VALUES (4, 32, 3, 20000, 2019-09-10 03:03:03, 1);
INSERT INTO Sales (TavernId, ServiceId, GuestId, Price, SaleTime, Amount) VALUES (4, 5, 77, 20000, 2019-09-10 03:03:03, 1);
*/