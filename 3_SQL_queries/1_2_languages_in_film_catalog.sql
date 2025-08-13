SELECT DISTINCT(name) AS _language_
FROM language
INNER JOIN film ON language.language_id = film.language_id;