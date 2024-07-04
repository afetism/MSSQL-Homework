--1. Display books with the minimum number of pages issued by a particular publishing house.
--1. H?r Publisherin ?n az s?hif?li kitab?n? ekrana ç?xar?n 
USE Library
SELECT Press.Name AS 'Name of Publisher',Books.Name AS 'Name of Books',Books.Pages
FROM BOOKS JOIN Press ON Books.Id_Press=Press.Id
WHERE Books.Pages=(
                   SELECT MIN(Books.Pages)
				   FROM Books
				   WHERE Books.Id_Press=Press.Id)


--2. Display the names of publishers who have issued books with an average number of pages larger than 100.	
--2. Publisherin ümumi çap etdiyi kitablar?n orta s?hif?si 100d?n yuxar?d?rsa, o Publisherl?ri ekrana ç?xar?n.
SELECT Press.Name AS 'Name of Press'
FROM Press JOIN Books ON Books.Id_Press=Press.Id
GROUP BY Press.Name
HAVING AVG(Books.Pages)>100

--3. Output the total amount of pages of all the books in the library issued by the publishing houses BHV and BINOM.
--3. BHV v? B?NOM Publisherl?rinin kitablar?n bütün c?mi s?hif?sini ekrana ç?xar?n
SELECT Press.Name AS 'Name of Press',SUM(Books.Pages) AS 'Total of Pages'
FROM Press JOIN Books ON Books.Id_Press=Press.Id
WHERE Press.Name='BHV' OR Press.Name='B?NOM'
GROUP BY Press.Name
--4. Select the names of all students who took books between January 1, 2001 and the current date.
--Yanvar?n 1-i 2001ci il v? bu gün aras?nda kitabxanadan kitab götür?n bütün t?l?b?l?rin adlar?n? ekrana ç?xar?n
SELECT Students.FirstName+' '+Students.LastName AS 'FullName of Students',S_Cards.DateOut
FROM S_Cards JOIN Students ON S_Cards.Id_Student=Students.Id
WHERE S_Cards.DateOut BETWEEN '1-01-2001' AND GETDATE()


--5. Find all students who are currently working with the book "Windows 2000 Registry" by Olga Kokoreva.
--5. Olga Kokorevan?n  "Windows 2000 Registry" kitab? üz?rind? i?l?y?n t?l?b?l?ri tap?n
SELECT Students.FirstName+' '+Students.LastName AS "FullName of Students"
FROM S_Cards JOIN Books ON S_Cards.Id_Book=Books.Id   
             JOIN Students ON S_Cards.Id_Book=Students.Id
WHERE Books.Name ='Windows 2000 Registry'

--6. Display information about authors whose average volume of books (in pages) is more than 600 pages.
--6. Yazd??? bütün kitablar? n?z?r? ald?qda, orta s?hif? say? 600d?n çox olan Yaz?ç?lar haqq?nda m?lumat ç?xar?n. 
SELECT Authors.FirstName AS 'Name of Authors'
FROM Authors JOIN Books ON Books.Id_Author=Authors.Id
GROUP BY Authors.FirstName
HAVING AVG(Books.Pages)>600
--7. Display information about publishers, whose total number of pages of books published by them is more than 700.
--7. Çap etdiyi bütün kitablar?n c?mi s?hif? say? 700d?n çox olan Publisherl?r haqq?nda ekrana m?lumat ç?xar?n
SELECT Press.Name AS 'Name of Press'
FROM Press JOIN Books ON Books.Id_Press=Press.Id
GROUP BY Press.Name
HAVING SUM(Books.Pages)>700