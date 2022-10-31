
use publications;

#1. Who Have Published What At Where?
SELECT authors.au_id, authors.au_fname AS Author_Firstname, authors.au_lname AS Author_Lastname, titleauthor.title_id AS TitleID, titles.title as Title, titles.pub_id AS Publisher_ID, publishers.pub_name AS Publisher
FROM authors, titleauthor, titles, publishers
WHERE titleauthor.au_id = authors.au_id AND titles.title_id = titleauthor.title_id AND publishers.pub_id = titles.pub_id;
#Same number of rows as titleauthor=25

#2.  Who Have Published How Many At Where?
#query how many titles each author has published at each publisher
SELECT authors.au_id, authors.au_fname AS Author_Firstname, authors.au_lname AS Author_Lastname, titleauthor.title_id AS TitleID, titles.title as Title, titles.pub_id AS Publisher_ID, publishers.pub_name AS Publisher,
COUNT(titles.title_id) AS Title_Count
FROM authors, titleauthor, titles, publishers
WHERE titleauthor.au_id = authors.au_id AND titles.title_id = titleauthor.title_id AND publishers.pub_id = titles.pub_id
GROUP BY titleauthor.au_id;
#To check if your output is correct, sum up the TITLE COUNT column. The sum number should be the same as the total number of records in Table titleauthor
#Yes, both are 25

#3. Best Selling Authors
# Who are the top 3 authors who have sold the highest number of titles?
# Your output should have:
# AUTHOR ID - the ID of the author / # LAST NAME - author last name /# FIRST NAME - author first name
# TOTAL - total number of titles sold from this author
# Your output should be ordered based on TOTAL from high to low.
# Only output the top 3 best selling authors.
# I need to sum all books sold by each author (qty, not moneys)

SELECT authors.au_id, authors.au_fname AS Author_Firstname, authors.au_lname AS Author_Lastname,
SUM(sales.qty) AS Quantity_Of_Books
FROM authors, titleauthor, titles, publishers, sales
WHERE titleauthor.au_id = authors.au_id AND sales.title_id = titleauthor.title_id
GROUP BY titleauthor.au_id
ORDER by Quantity_of_Books DESC
LIMIT 3;

#3B. If we want best selling by money earned, we can use titles.ytd_sales
SELECT authors.au_id, authors.au_fname AS Author_Firstname, authors.au_lname AS Author_Lastname,
SUM(titles.ytd_sales) AS YTD_Sales
FROM authors, titleauthor, titles, publishers, sales
WHERE titleauthor.au_id = authors.au_id AND titles.title_id = titleauthor.title_id
GROUP BY titleauthor.au_id
ORDER by YTD_Sales DESC
LIMIT 3;

-- 4. Best Selling Authors Ranking
-- Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. 
-- Note that the authors who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL). 
-- Also order your results based on TOTAL from high to low.
SELECT authors.au_id, authors.au_fname AS Author_Firstname, authors.au_lname AS Author_Lastname,
SUM(titles.ytd_sales) AS YTD_Sales
FROM authors, titleauthor, titles, publishers, sales
WHERE titleauthor.au_id = authors.au_id AND titles.title_id = titleauthor.title_id
GROUP BY titleauthor.au_id
ORDER by YTD_Sales DESC;

-- Bonus Challenge - Most Profiting Authors
-- PENDING