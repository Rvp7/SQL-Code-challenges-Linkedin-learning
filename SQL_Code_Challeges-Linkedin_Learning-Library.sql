---Checking for remaining books
SELECT
(SELECT count(*) FROM Books WHERE Title="Dracula")
-(SELECT count(*) FROM Books b JOIN Loans l
ON b.BookID=l.BookID
WHERE Title="Dracula" AND ReturnedDate IS NULL)
AS Remaining_Books;

---Add new books to the library
INSERT INTO Books 
(Title,Author,Published,Barcode) 
VALUES ("Dracula","Bram Stoker",1897,4819277482),
("Gulliver's Travels","Jonathan Swift",1729,4899254401);

---Check Out Books
INSERT INTO Loans 
(BookID,PatronID,LoanDate,DueDate) VALUES
((SELECT BookID FROM Books WHERE Barcode=2855934983),(SELECT PatronID FROM Patrons WHERE Email="jvaan@wisdompets.com"),"2020-08-25","2020-09-08"),
((SELECT BookID FROM Books WHERE Barcode=4043822646),(SELECT PatronID FROM Patrons WHERE Email="jvaan@wisdompets.com"), "2020-08-25","2020-09-08");

---Check for books due back, Email Reminder
SELECT p.FirstName,p.LastName,p.Email,b.Title,l.DueDate FROM
Patrons p JOIN loans l ON p.PatronID=l.PatronID
JOIN Books b ON l.BookID=b.BookID
WHERE l.DueDate="2020-07-13" AND l.ReturnedDate IS NULL;

---Return books to the library, get the information with SELECT query first and match titles and then...
UPDATE Loans SET ReturnedDate="2020-07-05"
WHERE BookID=
(SELECT BookID FROM Books WHERE 
---Change the barcode thrice
Barcode=8730298424) AND
ReturnedDate IS NULL;

--Encourage patrons to check out books
SELECT p.FirstName,p.LastName,p.Email,count(l.LoanID) as Total_Borrows
FROM Loans l JOIN Patrons p ON l.PatronID=p.PatronID
GROUP BY l.PatronID
ORDER BY Total_Borrows
LIMIT 10;

---Find books to feature for an event
SELECT Title,Barcode,Published FROM Books 
WHERE Published like "189_"
AND Barcode NOT IN
(SELECT b.Barcode FROM Loans l JOIN Books b
ON l.BookID=b.BookID
WHERE l.ReturnedDate IS NULL)
ORDER BY Published;
---OR Use this query
SELECT DISTINCT b.BookID,b.Title,b.Published FROM Books b JOIN Loans l
on b.BookID=l.BookID
WHERE Published BETWEEN 1890 AND 1899
AND ReturnedDate IS NOT NULL
ORDER BY Published;

---Book Statistics
---Report of books published each year
SELECT Published,count(DISTINCT Title) as Total_books
FROM Books
GROUP BY Published
ORDER BY Published;
---Report of Top 5 famous books among patrons
SELECT b.Title,count(l.LoanID) as Famous_books
FROM Loans l JOIN Books b
ON l.BookID=b.BookID
GROUP BY Title
ORDER BY Famous_books DESC
LIMIT 5;

