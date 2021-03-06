mysql> delimiter $$
mysql> CREATE PROCEDURE getSimilarCountries(input_country text)
    -> BEGIN
    -> DECLARE message text;
    -> DECLARE myregion text;
    -> DECLARE mylang text;
    -> DECLARE cntCountries int;
    -> SELECT region into myregion from country where Name = input_country;
    -> SELECT language into mylang from country as c, countrylanguage as cl
    -> WHERE c.code = cl.countrycode
    -> AND c.Name = input_country
    -> AND isofficial ='T';
    -> SELECT count(*) into cntCountries from country as c, countrylanguage as cl
    -> WHERE c.code = cl.countrycode
    -> AND region = myregion
    -> AND language = mylang
    -> AND isofficial = 'T';
    -> if (cntCountries > 1) then
    -> SELECT c.Name from country as c, countrylanguage as cl
    -> WHERE c.code = cl.countrycode
    -> AND region =myregion
    -> AND language=mylang
    -> AND isofficial= 'T';
    -> else
    -> SET message = 'FALSE: no such countries';
    -> SET lc_message=message;
    -> SIGNAL SQLSTATE='45000';
    -> end if;
    -> END;
    -> $$
    -> delimiter ;
