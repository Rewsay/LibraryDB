 -- Книги дороже 500 руб., доступные для выдачи, сортировка по цене
SELECT Title, Price, IsAvailable 
FROM Books 
WHERE Price > 500 AND IsAvailable = 1 
ORDER BY Price DESC;

-- Изменить цену книги с Id = 10
UPDATE Books SET Price = 699.99 WHERE BookId = 10;

-- Удалить читателя, который не активен и не брал книг (сначала удаляем связанные записи в Loans, если есть)
DELETE FROM Loans WHERE ReaderId IN (SELECT ReaderId FROM Readers WHERE IsActive = 0);
DELETE FROM Readers WHERE IsActive = 0;
 
 --Количество книг каждого автора (только авторы, у которых > 1 книги)
SELECT a.LastName, a.FirstName, COUNT(b.BookId) AS BookCount
FROM Authors a
LEFT JOIN Books b ON a.AuthorId = b.AuthorId
GROUP BY a.LastName, a.FirstName
HAVING COUNT(b.BookId) > 1;

SELECT r.FullName, b.Title, l.LoanDate
FROM Readers r
LEFT JOIN Loans l ON r.ReaderId = l.ReaderId
LEFT JOIN Books b ON l.BookId = b.BookId;

SELECT b.Title, l.LoanDate, r.FullName
FROM Loans l
RIGHT JOIN Books b ON l.BookId = b.BookId
LEFT JOIN Readers r ON l.ReaderId = r.ReaderId;

SELECT DISTINCT b.Title
FROM Books b
INNER JOIN Loans l ON b.BookId = l.BookId;