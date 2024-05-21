DROP SCHEMA IF EXISTS common CASCADE;

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.13

--
-- Name: common; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA common;

--
-- Name: continents; Type: TABLE; Schema: common; Owner: -
--

CREATE TABLE common.continents (
                                   code character varying(2) NOT NULL,
                                   name character varying(15) NOT NULL
);


--
-- Name: TABLE continents; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON TABLE common.continents IS 'Table for referencing continents';


--
-- Name: COLUMN continents.code; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.continents.code IS 'The unique 2-letter Continent Code';


--
-- Name: COLUMN continents.name; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.continents.name IS 'The unique continent name';


--
-- Name: countries; Type: TABLE; Schema: common; Owner: -
--

CREATE TABLE common.countries (
                                  code character varying(2) NOT NULL,
                                  name character varying(100) NOT NULL,
                                  continent_id character varying(2) NOT NULL,
                                  abbreviation character varying(100),
                                  default_currency_id character varying(3),
                                  dial_codes character varying(6)[]
);


--
-- Name: TABLE countries; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON TABLE common.countries IS 'Table for referencing country related information including continent and currency';


--
-- Name: COLUMN countries.code; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.countries.code IS 'The unique 2-letters ISO country code, used as primary key';


--
-- Name: COLUMN countries.name; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.countries.name IS 'The unique name of the country';


--
-- Name: COLUMN countries.continent_id; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.countries.continent_id IS 'The unique 2-letter continent code, foreign key to the continent table';


--
-- Name: COLUMN countries.abbreviation; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.countries.abbreviation IS 'An optional shorter version of the name';


--
-- Name: COLUMN countries.default_currency_id; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.countries.default_currency_id IS 'The unique 3-letter currency code, foreign key to the currency table';


--
-- Name: COLUMN countries.dial_codes; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.countries.dial_codes IS 'A list of accepted calling codes for the country';


--
-- Name: currencies; Type: TABLE; Schema: common; Owner: -
--

CREATE TABLE common.currencies (
                                   code character varying(3) NOT NULL,
                                   name character varying(50) NOT NULL,
                                   symbol character varying(6),
                                   short_symbol character varying(2)
);


--
-- Name: TABLE currencies; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON TABLE common.currencies IS 'Table for referencing monetary currencies';


--
-- Name: COLUMN currencies.code; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.currencies.code IS 'The currency 3-letter ISO code';


--
-- Name: COLUMN currencies.name; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.currencies.name IS 'The currency''s name';


--
-- Name: COLUMN currencies.symbol; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.currencies.symbol IS 'The symbol that denotes the currency, e.g. $ or €';


--
-- Name: COLUMN currencies.short_symbol; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON COLUMN common.currencies.short_symbol IS 'An optional shorter symbol for the currency, if needed';


--
-- Data for Name: continents; Type: TABLE DATA; Schema: common; Owner: -
--

INSERT INTO common.continents VALUES ('AF', 'Africa');
INSERT INTO common.continents VALUES ('AN', 'Antarctica');
INSERT INTO common.continents VALUES ('AS', 'Asia');
INSERT INTO common.continents VALUES ('EU', 'Europe');
INSERT INTO common.continents VALUES ('NA', 'North America');
INSERT INTO common.continents VALUES ('OC', 'Oceania');
INSERT INTO common.continents VALUES ('SA', 'South America');


--
-- Data for Name: countries; Type: TABLE DATA; Schema: common; Owner: -
--

INSERT INTO common.countries VALUES ('AD', 'Andorra', 'EU', NULL, 'EUR', '{+376}');
INSERT INTO common.countries VALUES ('AE', 'United Arab Emirates', 'AS', 'UAE', 'AED', '{+971}');
INSERT INTO common.countries VALUES ('AF', 'Afghanistan', 'AS', NULL, 'AFN', '{+93}');
INSERT INTO common.countries VALUES ('AG', 'Antigua and Barbuda', 'NA', 'ATG', 'XCD', '{+1268}');
INSERT INTO common.countries VALUES ('AI', 'Anguilla', 'NA', NULL, 'XCD', '{"+1 264"}');
INSERT INTO common.countries VALUES ('AL', 'Albania', 'EU', NULL, 'ALL', '{+355}');
INSERT INTO common.countries VALUES ('AM', 'Armenia', 'AS', NULL, 'AMD', '{+374}');
INSERT INTO common.countries VALUES ('AN', 'Netherlands Antilles', 'NA', 'ANT', 'ANG', '{+599}');
INSERT INTO common.countries VALUES ('AO', 'Angola', 'AF', NULL, 'AOA', '{+244}');
INSERT INTO common.countries VALUES ('AQ', 'Antarctica', 'AN', NULL, NULL, '{+672}');
INSERT INTO common.countries VALUES ('AR', 'Argentina', 'SA', NULL, 'ARS', '{+54}');
INSERT INTO common.countries VALUES ('AS', 'American Samoa', 'OC', NULL, 'USD', '{"+1 684"}');
INSERT INTO common.countries VALUES ('AT', 'Austria', 'EU', NULL, 'EUR', '{+43}');
INSERT INTO common.countries VALUES ('AU', 'Australia', 'OC', NULL, 'AUD', '{+61}');
INSERT INTO common.countries VALUES ('AW', 'Aruba', 'NA', NULL, 'AWG', '{+297}');
INSERT INTO common.countries VALUES ('AX', 'Åland Islands', 'EU', NULL, 'EUR', '{+358}');
INSERT INTO common.countries VALUES ('AZ', 'Azerbaijan', 'AS', NULL, 'AZN', '{+994}');
INSERT INTO common.countries VALUES ('BA', 'Bosnia and Herzegovina', 'EU', 'Bosnia', 'BAM', '{+387}');
INSERT INTO common.countries VALUES ('BB', 'Barbados', 'NA', NULL, 'BBD', '{"+1 246"}');
INSERT INTO common.countries VALUES ('BD', 'Bangladesh', 'AS', NULL, 'BDT', '{+880}');
INSERT INTO common.countries VALUES ('BE', 'Belgium', 'EU', NULL, 'EUR', '{+32}');
INSERT INTO common.countries VALUES ('BF', 'Burkina Faso', 'AF', NULL, 'XOF', '{+226}');
INSERT INTO common.countries VALUES ('BG', 'Bulgaria', 'EU', NULL, 'BGN', '{+359}');
INSERT INTO common.countries VALUES ('BH', 'Bahrain', 'AS', NULL, 'BHD', '{+973}');
INSERT INTO common.countries VALUES ('BI', 'Burundi', 'AF', NULL, 'BIF', '{+257}');
INSERT INTO common.countries VALUES ('BJ', 'Benin', 'AF', NULL, 'XOF', '{+229}');
INSERT INTO common.countries VALUES ('BL', 'Saint Barthélemy', 'NA', NULL, 'EUR', '{+590}');
INSERT INTO common.countries VALUES ('BM', 'Bermuda', 'NA', NULL, 'BMD', '{"+1 441"}');
INSERT INTO common.countries VALUES ('BN', 'Brunei Darussalam', 'AS', NULL, 'BND', '{+673}');
INSERT INTO common.countries VALUES ('BO', 'Bolivia', 'SA', NULL, 'BOB', '{+591}');
INSERT INTO common.countries VALUES ('BQ', 'Bonaire, Sint Eustatius and Saba', 'SA', NULL, 'USD', NULL);
INSERT INTO common.countries VALUES ('BR', 'Brazil', 'SA', NULL, 'BRL', '{+55}');
INSERT INTO common.countries VALUES ('BS', 'Bahamas', 'NA', NULL, 'BSD', '{"+1 242"}');
INSERT INTO common.countries VALUES ('BT', 'Bhutan', 'AS', NULL, 'BTN', '{+975}');
INSERT INTO common.countries VALUES ('BV', 'Bouvet Island', 'AN', NULL, 'NOK', '{+47}');
INSERT INTO common.countries VALUES ('BW', 'Botswana', 'AF', NULL, 'BWP', '{+267}');
INSERT INTO common.countries VALUES ('BY', 'Belarus', 'EU', NULL, 'BYN', '{+375}');
INSERT INTO common.countries VALUES ('BZ', 'Belize', 'NA', NULL, 'BZD', '{+501}');
INSERT INTO common.countries VALUES ('CA', 'Canada', 'NA', NULL, 'CAD', '{+1}');
INSERT INTO common.countries VALUES ('CC', 'Cocos (Keeling) Islands', 'OC', 'Cocos Islands', 'AUD', '{+61}');
INSERT INTO common.countries VALUES ('CD', 'Congo, The Democratic Republic of the', 'AF', 'Congo', 'CDF', '{+243}');
INSERT INTO common.countries VALUES ('CF', 'Central African Republic', 'AF', NULL, 'XAF', '{+236}');
INSERT INTO common.countries VALUES ('CG', 'Republic of the Congo', 'AF', NULL, 'CDF', '{+242}');
INSERT INTO common.countries VALUES ('CH', 'Switzerland', 'EU', NULL, 'CHF', '{+41}');
INSERT INTO common.countries VALUES ('CI', 'Cote D''Ivoire', 'AF', NULL, 'XOF', '{+225}');
INSERT INTO common.countries VALUES ('CK', 'Cook Islands', 'OC', NULL, 'NZD', '{+682}');
INSERT INTO common.countries VALUES ('CL', 'Chile', 'SA', NULL, 'CLP', '{+56}');
INSERT INTO common.countries VALUES ('CM', 'Cameroon', 'AF', NULL, 'XAF', '{+237}');
INSERT INTO common.countries VALUES ('CN', 'China', 'AS', NULL, 'CNY', '{+86}');
INSERT INTO common.countries VALUES ('CO', 'Colombia', 'SA', NULL, 'COP', '{+57}');
INSERT INTO common.countries VALUES ('CR', 'Costa Rica', 'NA', NULL, 'CRC', '{+506}');
INSERT INTO common.countries VALUES ('CU', 'Cuba', 'NA', NULL, NULL, '{+53}');
INSERT INTO common.countries VALUES ('CV', 'Cape Verde', 'AF', NULL, 'CVE', '{+238}');
INSERT INTO common.countries VALUES ('CW', 'Curaçao', 'SA', NULL, 'ANG', '{+599}');
INSERT INTO common.countries VALUES ('CX', 'Christmas Island', 'OC', NULL, 'AUD', '{+61}');
INSERT INTO common.countries VALUES ('CY', 'Cyprus', 'EU', NULL, 'EUR', '{+357}');
INSERT INTO common.countries VALUES ('CZ', 'Czech Republic', 'EU', 'Czech', 'CZK', '{+420}');
INSERT INTO common.countries VALUES ('DE', 'Germany', 'EU', NULL, 'EUR', '{+49}');
INSERT INTO common.countries VALUES ('DJ', 'Djibouti', 'AF', NULL, 'DJF', '{+253}');
INSERT INTO common.countries VALUES ('DK', 'Denmark', 'EU', NULL, 'DKK', '{+45}');
INSERT INTO common.countries VALUES ('DM', 'Dominica', 'NA', NULL, 'XCD', '{"+1 767"}');
INSERT INTO common.countries VALUES ('DO', 'Dominican Republic', 'NA', 'Dom Rep', 'DOP', '{"+1 849","+1 829","+1 809"}');
INSERT INTO common.countries VALUES ('DZ', 'Algeria', 'AF', NULL, 'DZD', '{+213}');
INSERT INTO common.countries VALUES ('EC', 'Ecuador', 'SA', NULL, 'USD', '{+593}');
INSERT INTO common.countries VALUES ('EE', 'Estonia', 'EU', NULL, 'EUR', '{+372}');
INSERT INTO common.countries VALUES ('EG', 'Egypt', 'AF', NULL, 'EGP', '{+20}');
INSERT INTO common.countries VALUES ('EH', 'Western Sahara', 'AF', NULL, 'MAD', '{+212}');
INSERT INTO common.countries VALUES ('ER', 'Eritrea', 'AF', NULL, NULL, '{+291}');
INSERT INTO common.countries VALUES ('ES', 'Spain', 'EU', NULL, 'EUR', '{+34}');
INSERT INTO common.countries VALUES ('ET', 'Ethiopia', 'AF', NULL, 'ETB', '{+251}');
INSERT INTO common.countries VALUES ('FI', 'Finland', 'EU', NULL, 'EUR', '{+358}');
INSERT INTO common.countries VALUES ('FJ', 'Fiji', 'OC', NULL, 'FJD', '{+679}');
INSERT INTO common.countries VALUES ('FK', 'Falkland Islands (Malvinas)', 'SA', NULL, 'FKP', '{+500}');
INSERT INTO common.countries VALUES ('FM', 'Micronesia, Federated States of', 'OC', 'Micronesia', 'USD', '{+691}');
INSERT INTO common.countries VALUES ('FO', 'Faroe Islands', 'EU', NULL, 'DKK', '{+298}');
INSERT INTO common.countries VALUES ('FR', 'France', 'EU', NULL, 'EUR', '{+33}');
INSERT INTO common.countries VALUES ('GA', 'Gabon', 'AF', NULL, 'XAF', '{+241}');
INSERT INTO common.countries VALUES ('GB', 'United Kingdom', 'EU', 'UK', 'GBP', '{+44}');
INSERT INTO common.countries VALUES ('GD', 'Grenada', 'NA', NULL, 'XCD', '{"+1 473"}');
INSERT INTO common.countries VALUES ('GE', 'Georgia', 'AS', NULL, 'GEL', '{+995}');
INSERT INTO common.countries VALUES ('GF', 'French Guiana', 'SA', NULL, 'EUR', '{+594}');
INSERT INTO common.countries VALUES ('GG', 'Guernsey', 'EU', NULL, 'GBP', '{+44}');
INSERT INTO common.countries VALUES ('GH', 'Ghana', 'AF', NULL, 'GHS', '{+233}');
INSERT INTO common.countries VALUES ('GI', 'Gibraltar', 'EU', NULL, 'GIP', '{+350}');
INSERT INTO common.countries VALUES ('GL', 'Greenland', 'NA', NULL, 'DKK', '{+299}');
INSERT INTO common.countries VALUES ('GM', 'Gambia', 'AF', NULL, 'GMD', '{+220}');
INSERT INTO common.countries VALUES ('GN', 'Guinea', 'AF', NULL, 'GNF', '{+224}');
INSERT INTO common.countries VALUES ('GP', 'Guadeloupe', 'NA', NULL, 'EUR', '{+590}');
INSERT INTO common.countries VALUES ('GQ', 'Equatorial Guinea', 'AF', NULL, 'XAF', '{+240}');
INSERT INTO common.countries VALUES ('GR', 'Greece', 'EU', NULL, 'EUR', '{+30}');
INSERT INTO common.countries VALUES ('GS', 'South Georgia and the South Sandwich Islands', 'AN', 'SGSSI', 'GBP', '{+500}');
INSERT INTO common.countries VALUES ('GT', 'Guatemala', 'NA', NULL, 'GTQ', '{+502}');
INSERT INTO common.countries VALUES ('GU', 'Guam', 'OC', NULL, 'USD', '{"+1 671"}');
INSERT INTO common.countries VALUES ('GW', 'Guinea-Bissau', 'AF', NULL, 'XOF', '{+245}');
INSERT INTO common.countries VALUES ('GY', 'Guyana', 'SA', NULL, 'GYD', '{+595}');
INSERT INTO common.countries VALUES ('HK', 'Hong Kong', 'AS', NULL, 'HKD', '{+852}');
INSERT INTO common.countries VALUES ('HM', 'Heard Island and Mcdonald Islands', 'AN', 'HIMI', 'AUD', '{+672}');
INSERT INTO common.countries VALUES ('HN', 'Honduras', 'NA', NULL, 'HNL', '{+504}');
INSERT INTO common.countries VALUES ('HR', 'Croatia', 'EU', NULL, 'HRK', '{+385}');
INSERT INTO common.countries VALUES ('HT', 'Haiti', 'NA', NULL, 'HTG', '{+509}');
INSERT INTO common.countries VALUES ('HU', 'Hungary', 'EU', NULL, 'HUF', '{+36}');
INSERT INTO common.countries VALUES ('ID', 'Indonesia', 'AS', NULL, 'IDR', '{+62}');
INSERT INTO common.countries VALUES ('IE', 'Ireland', 'EU', NULL, 'EUR', '{+353}');
INSERT INTO common.countries VALUES ('IL', 'Israel', 'AS', NULL, 'ILS', '{+972}');
INSERT INTO common.countries VALUES ('IM', 'Isle of Man', 'EU', NULL, 'GBP', '{+44}');
INSERT INTO common.countries VALUES ('IN', 'India', 'AS', NULL, 'INR', '{+91}');
INSERT INTO common.countries VALUES ('IO', 'British Indian Ocean Territory', 'AF', 'BIOT', 'USD', '{+246}');
INSERT INTO common.countries VALUES ('IQ', 'Iraq', 'AS', NULL, NULL, '{+964}');
INSERT INTO common.countries VALUES ('IR', 'Iran', 'AS', NULL, NULL, '{+98}');
INSERT INTO common.countries VALUES ('IS', 'Iceland', 'EU', NULL, 'ISK', '{+354}');
INSERT INTO common.countries VALUES ('IT', 'Italy', 'EU', NULL, 'EUR', '{+39}');
INSERT INTO common.countries VALUES ('JE', 'Jersey', 'EU', NULL, 'GBP', '{+44}');
INSERT INTO common.countries VALUES ('JM', 'Jamaica', 'NA', NULL, 'JMD', '{"+1 876"}');
INSERT INTO common.countries VALUES ('JO', 'Jordan', 'AS', NULL, 'JOD', '{+962}');
INSERT INTO common.countries VALUES ('JP', 'Japan', 'AS', NULL, 'JPY', '{+81}');
INSERT INTO common.countries VALUES ('KE', 'Kenya', 'AF', NULL, 'KES', '{+254}');
INSERT INTO common.countries VALUES ('KG', 'Kyrgyzstan', 'AS', NULL, 'KGS', '{+996}');
INSERT INTO common.countries VALUES ('KH', 'Cambodia', 'AS', NULL, 'KHR', '{+855}');
INSERT INTO common.countries VALUES ('KI', 'Kiribati', 'OC', NULL, 'AUD', '{+686}');
INSERT INTO common.countries VALUES ('KM', 'Comoros', 'AF', NULL, 'KMF', '{+269}');
INSERT INTO common.countries VALUES ('KN', 'Saint Kitts and Nevis', 'NA', NULL, 'XCD', '{"+1 869"}');
INSERT INTO common.countries VALUES ('KP', 'North Korea', 'AS', NULL, 'KPW', '{+850}');
INSERT INTO common.countries VALUES ('KR', 'South Korea', 'AS', NULL, 'KRW', '{+82}');
INSERT INTO common.countries VALUES ('KW', 'Kuwait', 'AS', NULL, 'KWD', '{+965}');
INSERT INTO common.countries VALUES ('KY', 'Cayman Islands', 'NA', NULL, 'KYD', '{"+ 345"}');
INSERT INTO common.countries VALUES ('KZ', 'Kazakhstan', 'AS', NULL, 'KZT', '{"+7 7"}');
INSERT INTO common.countries VALUES ('LA', 'Laos', 'AS', NULL, 'LAK', '{+856}');
INSERT INTO common.countries VALUES ('LB', 'Lebanon', 'AS', NULL, 'LBP', '{+961}');
INSERT INTO common.countries VALUES ('LC', 'Saint Lucia', 'NA', NULL, 'XCD', '{"+1 758"}');
INSERT INTO common.countries VALUES ('LI', 'Liechtenstein', 'EU', NULL, 'CHF', '{+423}');
INSERT INTO common.countries VALUES ('LK', 'Sri Lanka', 'AS', NULL, 'LKR', '{+94}');
INSERT INTO common.countries VALUES ('LR', 'Liberia', 'AF', NULL, NULL, '{+231}');
INSERT INTO common.countries VALUES ('LS', 'Lesotho', 'AF', NULL, 'LSL', '{+266}');
INSERT INTO common.countries VALUES ('LT', 'Lithuania', 'EU', NULL, 'EUR', '{+370}');
INSERT INTO common.countries VALUES ('LU', 'Luxembourg', 'EU', NULL, 'EUR', '{+352}');
INSERT INTO common.countries VALUES ('LV', 'Latvia', 'EU', NULL, 'EUR', '{+371}');
INSERT INTO common.countries VALUES ('LY', 'Libya', 'AF', NULL, 'LYD', '{+218}');
INSERT INTO common.countries VALUES ('MA', 'Morocco', 'AF', NULL, 'MAD', '{+212}');
INSERT INTO common.countries VALUES ('MC', 'Monaco', 'EU', NULL, 'EUR', '{+377}');
INSERT INTO common.countries VALUES ('MD', 'Moldova, Republic of', 'EU', 'Moldova', 'MDL', '{+373}');
INSERT INTO common.countries VALUES ('ME', 'Montenegro', 'EU', NULL, 'EUR', '{+382}');
INSERT INTO common.countries VALUES ('MF', 'Saint Martin', 'NA', NULL, 'EUR', '{+590}');
INSERT INTO common.countries VALUES ('MG', 'Madagascar', 'AF', NULL, 'MGA', '{+261}');
INSERT INTO common.countries VALUES ('MH', 'Marshall Islands', 'OC', NULL, 'USD', '{+692}');
INSERT INTO common.countries VALUES ('MK', 'North Macedonia', 'EU', 'Macedonia', 'MKD', '{+389}');
INSERT INTO common.countries VALUES ('ML', 'Mali', 'AF', NULL, 'XOF', '{+223}');
INSERT INTO common.countries VALUES ('MM', 'Myanmar', 'AS', NULL, 'MMK', '{+95}');
INSERT INTO common.countries VALUES ('MN', 'Mongolia', 'AS', NULL, 'MNT', '{+976}');
INSERT INTO common.countries VALUES ('MO', 'Macao', 'AS', NULL, 'MOP', '{+853}');
INSERT INTO common.countries VALUES ('MP', 'Northern Mariana Islands', 'OC', 'CNMI', 'USD', '{"+1 670"}');
INSERT INTO common.countries VALUES ('MQ', 'Martinique', 'NA', NULL, 'EUR', '{+596}');
INSERT INTO common.countries VALUES ('MR', 'Mauritania', 'AF', NULL, 'MRU', '{+222}');
INSERT INTO common.countries VALUES ('MS', 'Montserrat', 'NA', NULL, 'XCD', '{+1664}');
INSERT INTO common.countries VALUES ('MT', 'Malta', 'EU', NULL, 'EUR', '{+356}');
INSERT INTO common.countries VALUES ('MU', 'Mauritius', 'AF', NULL, 'MUR', '{+230}');
INSERT INTO common.countries VALUES ('MV', 'Maldives', 'AS', NULL, 'MVR', '{+960}');
INSERT INTO common.countries VALUES ('MW', 'Malawi', 'AF', NULL, 'MWK', '{+265}');
INSERT INTO common.countries VALUES ('MX', 'Mexico', 'NA', NULL, 'MXN', '{+52}');
INSERT INTO common.countries VALUES ('MY', 'Malaysia', 'AS', NULL, 'MYR', '{+60}');
INSERT INTO common.countries VALUES ('MZ', 'Mozambique', 'AF', NULL, 'MZN', '{+258}');
INSERT INTO common.countries VALUES ('NA', 'Namibia', 'AF', NULL, 'ZAR', '{+264}');
INSERT INTO common.countries VALUES ('NC', 'New Caledonia', 'OC', NULL, 'XPF', '{+687}');
INSERT INTO common.countries VALUES ('NE', 'Niger', 'AF', NULL, 'XOF', '{+227}');
INSERT INTO common.countries VALUES ('NF', 'Norfolk Island', 'OC', NULL, 'AUD', '{+672}');
INSERT INTO common.countries VALUES ('NG', 'Nigeria', 'AF', NULL, 'NGN', '{+234}');
INSERT INTO common.countries VALUES ('NI', 'Nicaragua', 'NA', NULL, 'NIO', '{+505}');
INSERT INTO common.countries VALUES ('NL', 'Netherlands', 'EU', NULL, 'EUR', '{+31}');
INSERT INTO common.countries VALUES ('NO', 'Norway', 'EU', NULL, 'NOK', '{+47}');
INSERT INTO common.countries VALUES ('NP', 'Nepal', 'AS', NULL, 'NPR', '{+977}');
INSERT INTO common.countries VALUES ('NR', 'Nauru', 'OC', NULL, 'AUD', '{+674}');
INSERT INTO common.countries VALUES ('NU', 'Niue', 'OC', NULL, 'NZD', '{+683}');
INSERT INTO common.countries VALUES ('NZ', 'New Zealand', 'OC', NULL, 'NZD', '{+64}');
INSERT INTO common.countries VALUES ('OM', 'Oman', 'AS', NULL, 'OMR', '{+968}');
INSERT INTO common.countries VALUES ('PA', 'Panama', 'NA', NULL, 'USD', '{+507}');
INSERT INTO common.countries VALUES ('PE', 'Peru', 'SA', NULL, 'PEN', '{+51}');
INSERT INTO common.countries VALUES ('PF', 'French Polynesia', 'OC', NULL, 'XPF', '{+689}');
INSERT INTO common.countries VALUES ('PG', 'Papua New Guinea', 'OC', NULL, 'PGK', '{+675}');
INSERT INTO common.countries VALUES ('PH', 'Philippines', 'AS', NULL, 'PHP', '{+63}');
INSERT INTO common.countries VALUES ('PK', 'Pakistan', 'AS', NULL, 'PKR', '{+92}');
INSERT INTO common.countries VALUES ('PL', 'Poland', 'EU', NULL, 'PLN', '{+48}');
INSERT INTO common.countries VALUES ('PM', 'Saint Pierre and Miquelon', 'NA', NULL, 'EUR', '{+508}');
INSERT INTO common.countries VALUES ('PN', 'Pitcairn', 'OC', NULL, 'NZD', '{+872}');
INSERT INTO common.countries VALUES ('PR', 'Puerto Rico', 'NA', NULL, 'USD', '{"+1 939"}');
INSERT INTO common.countries VALUES ('PS', 'Palestine', 'AS', NULL, NULL, '{+970}');
INSERT INTO common.countries VALUES ('PT', 'Portugal', 'EU', NULL, 'EUR', '{+351}');
INSERT INTO common.countries VALUES ('PW', 'Palau', 'OC', NULL, 'USD', '{+680}');
INSERT INTO common.countries VALUES ('PY', 'Paraguay', 'SA', NULL, 'PYG', '{+595}');
INSERT INTO common.countries VALUES ('QA', 'Qatar', 'AS', NULL, 'QAR', '{+974}');
INSERT INTO common.countries VALUES ('RE', 'Reunion', 'AF', NULL, 'EUR', '{+262}');
INSERT INTO common.countries VALUES ('RO', 'Romania', 'EU', NULL, 'RON', '{+40}');
INSERT INTO common.countries VALUES ('RS', 'Serbia', 'EU', NULL, 'RSD', '{+381}');
INSERT INTO common.countries VALUES ('RU', 'Russia', 'EU', NULL, 'RUB', '{+7}');
INSERT INTO common.countries VALUES ('RW', 'Rwanda', 'AF', NULL, 'RWF', '{+250}');
INSERT INTO common.countries VALUES ('SA', 'Saudi Arabia', 'AS', NULL, 'SAR', '{+966}');
INSERT INTO common.countries VALUES ('SB', 'Solomon Islands', 'OC', NULL, 'SBD', '{+677}');
INSERT INTO common.countries VALUES ('SC', 'Seychelles', 'AF', NULL, 'SCR', '{+248}');
INSERT INTO common.countries VALUES ('SD', 'Sudan', 'AF', NULL, 'SDG', '{+249}');
INSERT INTO common.countries VALUES ('SE', 'Sweden', 'EU', NULL, 'SEK', '{+46}');
INSERT INTO common.countries VALUES ('SG', 'Singapore', 'AS', NULL, 'SGD', '{+65}');
INSERT INTO common.countries VALUES ('SH', 'Saint Helena', 'AF', NULL, 'SHP', '{+290}');
INSERT INTO common.countries VALUES ('SI', 'Slovenia', 'EU', NULL, 'EUR', '{+386}');
INSERT INTO common.countries VALUES ('SJ', 'Svalbard and Jan Mayen', 'EU', NULL, 'NOK', '{+47}');
INSERT INTO common.countries VALUES ('SK', 'Slovakia', 'EU', NULL, 'EUR', '{+421}');
INSERT INTO common.countries VALUES ('SL', 'Sierra Leone', 'AF', NULL, 'SLL', '{+232}');
INSERT INTO common.countries VALUES ('SM', 'San Marino', 'EU', NULL, 'EUR', '{+378}');
INSERT INTO common.countries VALUES ('SN', 'Senegal', 'AF', NULL, 'XOF', '{+221}');
INSERT INTO common.countries VALUES ('SO', 'Somalia', 'AF', NULL, 'SOS', '{+252}');
INSERT INTO common.countries VALUES ('SR', 'Suriname', 'SA', NULL, 'SRD', '{+597}');
INSERT INTO common.countries VALUES ('SS', 'South Sudan', 'AF', NULL, 'SSP', '{+211}');
INSERT INTO common.countries VALUES ('ST', 'Sao Tome and Principe', 'AF', NULL, 'STN', '{+239}');
INSERT INTO common.countries VALUES ('SV', 'El Salvador', 'NA', NULL, 'USD', '{+503}');
INSERT INTO common.countries VALUES ('SX', 'Sint Maarten', 'NA', NULL, NULL, '{+1-721}');
INSERT INTO common.countries VALUES ('SY', 'Syria', 'AS', NULL, 'USD', '{+963}');
INSERT INTO common.countries VALUES ('SZ', 'Swaziland', 'AF', NULL, 'SZL', '{+268}');
INSERT INTO common.countries VALUES ('TC', 'Turks and Caicos Islands', 'NA', NULL, 'USD', '{"+1 649"}');
INSERT INTO common.countries VALUES ('TD', 'Chad', 'AF', NULL, 'XAF', '{+235}');
INSERT INTO common.countries VALUES ('TF', 'French Southern Territories', 'AN', NULL, 'EUR', '{+33}');
INSERT INTO common.countries VALUES ('TG', 'Togo', 'AF', NULL, 'XOF', '{+228}');
INSERT INTO common.countries VALUES ('TH', 'Thailand', 'AS', NULL, 'THB', '{+66}');
INSERT INTO common.countries VALUES ('TJ', 'Tajikistan', 'AS', NULL, 'TJS', '{+992}');
INSERT INTO common.countries VALUES ('TK', 'Tokelau', 'OC', NULL, 'NZD', '{+690}');
INSERT INTO common.countries VALUES ('TL', 'Timor-Leste', 'AS', NULL, 'USD', '{+670}');
INSERT INTO common.countries VALUES ('TM', 'Turkmenistan', 'AS', NULL, 'TMT', '{+993}');
INSERT INTO common.countries VALUES ('TN', 'Tunisia', 'AF', NULL, 'TND', '{+216}');
INSERT INTO common.countries VALUES ('TO', 'Tonga', 'OC', NULL, 'TOP', '{+676}');
INSERT INTO common.countries VALUES ('TR', 'Turkey', 'AS', NULL, 'TRY', '{+90}');
INSERT INTO common.countries VALUES ('TT', 'Trinidad and Tobago', 'NA', NULL, 'TTD', '{"+1 868"}');
INSERT INTO common.countries VALUES ('TV', 'Tuvalu', 'OC', NULL, 'AUD', '{+688}');
INSERT INTO common.countries VALUES ('TW', 'Taiwan', 'AS', NULL, 'TWD', '{+886}');
INSERT INTO common.countries VALUES ('TZ', 'Tanzania, United Republic of', 'AF', 'Tanzania', 'TZS', '{+255}');
INSERT INTO common.countries VALUES ('UA', 'Ukraine', 'EU', NULL, 'UAH', '{+380}');
INSERT INTO common.countries VALUES ('UG', 'Uganda', 'AF', NULL, 'UGX', '{+256}');
INSERT INTO common.countries VALUES ('US', 'United States', 'NA', 'USA', 'USD', '{+1}');
INSERT INTO common.countries VALUES ('UY', 'Uruguay', 'SA', NULL, 'UYU', '{+598}');
INSERT INTO common.countries VALUES ('UZ', 'Uzbekistan', 'AS', NULL, 'UZS', '{+998}');
INSERT INTO common.countries VALUES ('VA', 'Holy See (Vatican City State)', 'EU', NULL, 'EUR', '{+379}');
INSERT INTO common.countries VALUES ('VC', 'Saint Vincent and the Grenadines', 'NA', ' Saint Vincent', 'XCD', '{"+1 784"}');
INSERT INTO common.countries VALUES ('VE', 'Venezuela', 'SA', NULL, 'VES', '{+58}');
INSERT INTO common.countries VALUES ('VG', 'Virgin Islands, British', 'NA', NULL, 'USD', '{"+1 284"}');
INSERT INTO common.countries VALUES ('VI', 'Virgin Islands, U.S.', 'NA', NULL, 'USD', '{"+1 340"}');
INSERT INTO common.countries VALUES ('VN', 'Viet Nam', 'AS', NULL, 'VND', '{+84}');
INSERT INTO common.countries VALUES ('VU', 'Vanuatu', 'OC', NULL, 'VUV', '{+678}');
INSERT INTO common.countries VALUES ('WF', 'Wallis and Futuna', 'OC', NULL, 'XPF', '{+681}');
INSERT INTO common.countries VALUES ('WS', 'Samoa', 'OC', NULL, 'WST', '{+685}');
INSERT INTO common.countries VALUES ('XK', 'Kosovo', 'EU', NULL, 'EUR', '{+383}');
INSERT INTO common.countries VALUES ('YE', 'Yemen', 'AS', NULL, 'YER', '{+967}');
INSERT INTO common.countries VALUES ('YT', 'Mayotte', 'AF', NULL, 'EUR', '{+262}');
INSERT INTO common.countries VALUES ('ZA', 'South Africa', 'AF', NULL, 'ZAR', '{+27}');
INSERT INTO common.countries VALUES ('ZM', 'Zambia', 'AF', NULL, 'ZMW', '{+260}');
INSERT INTO common.countries VALUES ('ZW', 'Zimbabwe', 'AF', NULL, 'ZWL', '{+263}');


--
-- Data for Name: currencies; Type: TABLE DATA; Schema: common; Owner: -
--

INSERT INTO common.currencies VALUES ('AED', 'United Arab Emirates Dirham', 'د.إ', NULL);
INSERT INTO common.currencies VALUES ('AFN', 'Afghani', '؋', NULL);
INSERT INTO common.currencies VALUES ('ALL', 'Albanian Lek', 'L', NULL);
INSERT INTO common.currencies VALUES ('AMD', 'Armenian Dram', '֏', NULL);
INSERT INTO common.currencies VALUES ('ANG', 'Netherlands Antillean Guilder', 'ƒ', NULL);
INSERT INTO common.currencies VALUES ('AOA', 'Kwanza', 'Kz', NULL);
INSERT INTO common.currencies VALUES ('ARS', 'Argentine Peso', '$A', '$');
INSERT INTO common.currencies VALUES ('AUD', 'Australian Dollar', 'A$', '$');
INSERT INTO common.currencies VALUES ('AWG', 'Aruban Florin', 'ƒ', NULL);
INSERT INTO common.currencies VALUES ('AZN', 'Azerbaijani Manat', '₼', NULL);
INSERT INTO common.currencies VALUES ('BAM', 'Bosnia and Herzegovina Convertible Mark', 'KM', NULL);
INSERT INTO common.currencies VALUES ('BBD', 'Barbadian Dollar', 'Bds$', '$');
INSERT INTO common.currencies VALUES ('BDT', 'Bangladeshi Taka', '৳', NULL);
INSERT INTO common.currencies VALUES ('BGN', 'Bulgarian Lev', 'лв', NULL);
INSERT INTO common.currencies VALUES ('BHD', 'Bahraini Dinar', 'BD', NULL);
INSERT INTO common.currencies VALUES ('BIF', 'Burundi Franc', 'FBu', NULL);
INSERT INTO common.currencies VALUES ('BMD', 'Bermudian Dollar', '$', NULL);
INSERT INTO common.currencies VALUES ('BND', 'Brunei Dollar', '$', NULL);
INSERT INTO common.currencies VALUES ('BOB', 'Bolivian Boliviano', 'Bs', NULL);
INSERT INTO common.currencies VALUES ('BRL', 'Brazilian Real', 'R$', '$');
INSERT INTO common.currencies VALUES ('BSD', 'Bahamian Dollar', '$', NULL);
INSERT INTO common.currencies VALUES ('BTN', 'Ngultrum', 'Nu.', NULL);
INSERT INTO common.currencies VALUES ('BWP', 'Pula', 'P', NULL);
INSERT INTO common.currencies VALUES ('BYN', 'Belarusian Ruble', 'Br', NULL);
INSERT INTO common.currencies VALUES ('BZD', 'Belize Dollar', '$', NULL);
INSERT INTO common.currencies VALUES ('CAD', 'Canadian Dollar', 'C$', '$');
INSERT INTO common.currencies VALUES ('CDF', 'Congolese Franc', 'Fr', NULL);
INSERT INTO common.currencies VALUES ('CHF', 'Swiss Franc', 'Fr', NULL);
INSERT INTO common.currencies VALUES ('CLP', 'Chilean Peso', 'CLP$', '$');
INSERT INTO common.currencies VALUES ('CNY', 'Chinese Yuan', '¥', NULL);
INSERT INTO common.currencies VALUES ('COP', 'Colombian Peso', 'COP$', '$');
INSERT INTO common.currencies VALUES ('CRC', 'Costa Rican Colon', '₡', NULL);
INSERT INTO common.currencies VALUES ('CUP', 'Cuban Peso', '$', NULL);
INSERT INTO common.currencies VALUES ('CVE', 'Cape Verdean Escudo', '$', NULL);
INSERT INTO common.currencies VALUES ('CZK', 'Czech Koruna', 'Kč', NULL);
INSERT INTO common.currencies VALUES ('DJF', 'Djiboutian Franc', 'Fr', NULL);
INSERT INTO common.currencies VALUES ('DKK', 'Danish Krone', 'kr', NULL);
INSERT INTO common.currencies VALUES ('DOP', 'Dominican Peso', 'RD$', NULL);
INSERT INTO common.currencies VALUES ('DZD', 'Algerian Dinar', 'د.ج', NULL);
INSERT INTO common.currencies VALUES ('EGP', 'Egyptian Pound', 'E£', '£');
INSERT INTO common.currencies VALUES ('ERN', 'Eritrean Nakfa', 'Nkf', NULL);
INSERT INTO common.currencies VALUES ('ETB', 'Ethiopian Birr', 'Br', NULL);
INSERT INTO common.currencies VALUES ('EUR', 'Euro', '€', NULL);
INSERT INTO common.currencies VALUES ('FJD', 'Fijian Dollar', '$', NULL);
INSERT INTO common.currencies VALUES ('FKP', 'Falkland Islands Pound', '£', NULL);
INSERT INTO common.currencies VALUES ('GBP', 'British Pound', '£', NULL);
INSERT INTO common.currencies VALUES ('GEL', 'Georgian Lari', '₾', NULL);
INSERT INTO common.currencies VALUES ('GHS', 'Ghanaian Cedi', 'GH₵', '₵');
INSERT INTO common.currencies VALUES ('GIP', 'Gibraltar Pound', '£', NULL);
INSERT INTO common.currencies VALUES ('GMD', 'Gambian Dalasi', 'D', NULL);
INSERT INTO common.currencies VALUES ('GNF', 'Guinea Franc', 'FG', NULL);
INSERT INTO common.currencies VALUES ('GTQ', 'Guatemalan Quetzal', 'Q', NULL);
INSERT INTO common.currencies VALUES ('GYD', 'Guyanese Dollar', 'G$', '$');
INSERT INTO common.currencies VALUES ('HKD', 'Hong Kong Dollar', 'HK$', '$');
INSERT INTO common.currencies VALUES ('HNL', 'Honduran Lempira', 'L', NULL);
INSERT INTO common.currencies VALUES ('HRK', 'Croatian Kuna', 'kn', NULL);
INSERT INTO common.currencies VALUES ('HTG', 'Haitian Gourde', 'G', NULL);
INSERT INTO common.currencies VALUES ('HUF', 'Hungarian Forint', 'Ft', NULL);
INSERT INTO common.currencies VALUES ('IDR', 'Indonesian Rupiah', 'Rp', NULL);
INSERT INTO common.currencies VALUES ('ILS', 'Israeli New Shekel', '₪', NULL);
INSERT INTO common.currencies VALUES ('INR', 'Indian Rupee', '₹', NULL);
INSERT INTO common.currencies VALUES ('IQD', 'Iraqi Dinar', 'ع.د', NULL);
INSERT INTO common.currencies VALUES ('ISK', 'Icelandic Króna', 'kr', NULL);
INSERT INTO common.currencies VALUES ('JMD', 'Jamaican Dollar', 'J$', '$');
INSERT INTO common.currencies VALUES ('JOD', 'Jordanian Dinar', 'د.ا', NULL);
INSERT INTO common.currencies VALUES ('JPY', 'Japanese Yen', '¥', NULL);
INSERT INTO common.currencies VALUES ('KES', 'Kenyan Shilling', 'KES', NULL);
INSERT INTO common.currencies VALUES ('KGS', 'Kyrgyzstani Som', 'с', NULL);
INSERT INTO common.currencies VALUES ('KHR', 'Cambodian Riel', '៛', NULL);
INSERT INTO common.currencies VALUES ('KMF', 'Comorian Franc', 'Fr', NULL);
INSERT INTO common.currencies VALUES ('KPW', 'North Korean Won', '₩', NULL);
INSERT INTO common.currencies VALUES ('KRW', 'South Korean Won', '₩', NULL);
INSERT INTO common.currencies VALUES ('KWD', 'Kuwaiti Dinar', 'K.D.', NULL);
INSERT INTO common.currencies VALUES ('KYD', 'Cayman Islands Dollar', '$', NULL);
INSERT INTO common.currencies VALUES ('KZT', 'Kazakhstani Tenge', '₸', NULL);
INSERT INTO common.currencies VALUES ('LAK', 'Kip', '₭', NULL);
INSERT INTO common.currencies VALUES ('LBP', 'Lebanese Pound', 'ل.ل', NULL);
INSERT INTO common.currencies VALUES ('LKR', 'Sri Lankan Rupee', 'රු', NULL);
INSERT INTO common.currencies VALUES ('LSL', 'Lesotho Loti', 'L', NULL);
INSERT INTO common.currencies VALUES ('LTL', 'Lithuania Litas', 'Lt', NULL);
INSERT INTO common.currencies VALUES ('LVL', 'Latvian Lats', 'Ls', NULL);
INSERT INTO common.currencies VALUES ('LYD', 'Libyan Dinar', 'ل.د', NULL);
INSERT INTO common.currencies VALUES ('MAD', 'Moroccan Dirham', '‎DH', NULL);
INSERT INTO common.currencies VALUES ('MDL', 'Moldovan Leu', 'lei', NULL);
INSERT INTO common.currencies VALUES ('MGA', 'Malagasy Ariary', 'Ar', NULL);
INSERT INTO common.currencies VALUES ('MKD', 'Macedonian Denar', 'Ден', NULL);
INSERT INTO common.currencies VALUES ('MMK', 'Burmese Kyat', 'Ks', NULL);
INSERT INTO common.currencies VALUES ('MNT', 'Mongolian Tögrög', '₮', NULL);
INSERT INTO common.currencies VALUES ('MOP', 'Macanese Pataca', 'MOP$', '$');
INSERT INTO common.currencies VALUES ('MRO', 'Mauritanian Ouguiya', 'UM', NULL);
INSERT INTO common.currencies VALUES ('MRU', 'Mauritanian Ouguiya', 'UM', NULL);
INSERT INTO common.currencies VALUES ('MUR', 'Mauritian Rupee', '₨', NULL);
INSERT INTO common.currencies VALUES ('MVR', 'Maldivian Rufiyaa', '.ރ', NULL);
INSERT INTO common.currencies VALUES ('MWK', 'Malawian Kwacha', 'MK', NULL);
INSERT INTO common.currencies VALUES ('MXN', 'Mexican Peso', 'MXN', NULL);
INSERT INTO common.currencies VALUES ('MYR', 'Malaysian Ringgit', 'RM', NULL);
INSERT INTO common.currencies VALUES ('MZN', 'Mozambican Metical', 'MT', NULL);
INSERT INTO common.currencies VALUES ('NAD', 'Namibia Dollar', 'N$', '$');
INSERT INTO common.currencies VALUES ('NGN', 'Nigerian Naira', '₦', NULL);
INSERT INTO common.currencies VALUES ('NIO', 'Nicaraguan Córdoba', 'C$', '$');
INSERT INTO common.currencies VALUES ('NOK', 'Norwegian Krone', 'kr', NULL);
INSERT INTO common.currencies VALUES ('NPR', 'Nepalese Rupee', '‎रू', NULL);
INSERT INTO common.currencies VALUES ('NZD', 'New Zealand Dollar', 'NZ$', '$');
INSERT INTO common.currencies VALUES ('OMR', 'Omani Rial', 'ر.ع.', NULL);
INSERT INTO common.currencies VALUES ('PAB', 'Panamanian Balboa', 'B/.', NULL);
INSERT INTO common.currencies VALUES ('PEN', 'Peruvian Sol', 'PEN', NULL);
INSERT INTO common.currencies VALUES ('PGK', 'Kina', 'K', NULL);
INSERT INTO common.currencies VALUES ('PHP', 'Philippine Peso', '₱', NULL);
INSERT INTO common.currencies VALUES ('PKR', 'Pakistani Rupee', 'Rs', NULL);
INSERT INTO common.currencies VALUES ('PLN', 'Polish Złoty', 'zł', NULL);
INSERT INTO common.currencies VALUES ('PYG', 'Paraguayan Guarani', 'Gs', NULL);
INSERT INTO common.currencies VALUES ('QAR', 'Qatari Riyal', 'ر.ق', NULL);
INSERT INTO common.currencies VALUES ('RON', 'Romanian Leu', 'lei', NULL);
INSERT INTO common.currencies VALUES ('RSD', 'Serbian Dinar', 'дин.', NULL);
INSERT INTO common.currencies VALUES ('RUB', 'Russian Ruble', '₽', NULL);
INSERT INTO common.currencies VALUES ('RWF', 'Rwandan Franc', 'Fr', NULL);
INSERT INTO common.currencies VALUES ('SAR', 'Saudi Riyal', '﷼', NULL);
INSERT INTO common.currencies VALUES ('SBD', 'Solomon Islands Dollar', '$', NULL);
INSERT INTO common.currencies VALUES ('SCR', 'Seychellois Rupee', '₨', NULL);
INSERT INTO common.currencies VALUES ('SDG', 'Sudanese Pound', 'LS', NULL);
INSERT INTO common.currencies VALUES ('SEK', 'Swedish Krona', 'kr', NULL);
INSERT INTO common.currencies VALUES ('SGD', 'Singapore Dollar', 'S$', '$');
INSERT INTO common.currencies VALUES ('SHP', 'Saint Helena Pound', '£', NULL);
INSERT INTO common.currencies VALUES ('SLL', 'Sierra Leonean Leone', 'Le', NULL);
INSERT INTO common.currencies VALUES ('SOS', 'Somali Shilling', 'Sh.So.', NULL);
INSERT INTO common.currencies VALUES ('SRD', 'Surinamese Dollar', '$', NULL);
INSERT INTO common.currencies VALUES ('SSP', 'South Sudanese Pound', '£', NULL);
INSERT INTO common.currencies VALUES ('STN', 'São Tomé and Príncipe Dobra', 'Db', NULL);
INSERT INTO common.currencies VALUES ('SVC', 'Salvadoran Colón', '$', NULL);
INSERT INTO common.currencies VALUES ('SYP', 'Syrian Pound', '£', NULL);
INSERT INTO common.currencies VALUES ('SZL', 'Swazi Lilangeni', 'L', NULL);
INSERT INTO common.currencies VALUES ('THB', 'Thai Baht', '฿', NULL);
INSERT INTO common.currencies VALUES ('TJS', 'Tajikistani Somoni', 'ЅМ', NULL);
INSERT INTO common.currencies VALUES ('TMT', 'Turkmenistan Manat', 'm', NULL);
INSERT INTO common.currencies VALUES ('TND', 'Tunisian Dinar', 'د.ت', NULL);
INSERT INTO common.currencies VALUES ('TOP', 'Tongan Paʻanga', 'T$', '$');
INSERT INTO common.currencies VALUES ('TRY', 'Turkish Lira', '₺', NULL);
INSERT INTO common.currencies VALUES ('TTD', 'Trinidad and Tobago Dollar', '$', NULL);
INSERT INTO common.currencies VALUES ('TWD', 'New Taiwan Dollar', 'NT$', '$');
INSERT INTO common.currencies VALUES ('TZS', 'Tanzanian Shilling', 'Sh', NULL);
INSERT INTO common.currencies VALUES ('UAH', 'Ukrainian Hryvnia', '₴', NULL);
INSERT INTO common.currencies VALUES ('UGX', 'Ugandan Shilling', 'Sh', NULL);
INSERT INTO common.currencies VALUES ('USD', 'US Dollar', '$', NULL);
INSERT INTO common.currencies VALUES ('UYU', 'Uruguayan Peso', '$U', '$');
INSERT INTO common.currencies VALUES ('UZS', 'Uzbekistani Soum', 'so''m', NULL);
INSERT INTO common.currencies VALUES ('VES', 'Venezuelan Bolívar Soberano', 'Bs.', NULL);
INSERT INTO common.currencies VALUES ('VND', 'Vietnamese Dồng', '₫', NULL);
INSERT INTO common.currencies VALUES ('VUV', 'Vanuatu Vatu', 'Vt', NULL);
INSERT INTO common.currencies VALUES ('WST', 'Samoan Tālā', 'T', NULL);
INSERT INTO common.currencies VALUES ('XAF', 'Central African CFA franc', 'Fr', NULL);
INSERT INTO common.currencies VALUES ('XAG', 'Silver', '', NULL);
INSERT INTO common.currencies VALUES ('XAU', 'Gold', '', NULL);
INSERT INTO common.currencies VALUES ('XCD', 'East Caribbean Dollar', '$', NULL);
INSERT INTO common.currencies VALUES ('XOF', 'West African CFA Franc', 'Fr', NULL);
INSERT INTO common.currencies VALUES ('XPF', 'CFP Franc', '₣', NULL);
INSERT INTO common.currencies VALUES ('YER', 'Yemeni Rial', '﷼', NULL);
INSERT INTO common.currencies VALUES ('ZAR', 'South African Rand', 'R', NULL);
INSERT INTO common.currencies VALUES ('ZMW', 'Zambian Kwacha', 'ZK', NULL);
INSERT INTO common.currencies VALUES ('ZWL', 'Zimbabwean Dollar', 'Z$', NULL);


--
-- Name: continents continents_name_key; Type: CONSTRAINT; Schema: common; Owner: -
--

ALTER TABLE ONLY common.continents
    ADD CONSTRAINT continents_name_key UNIQUE (name);


--
-- Name: continents continents_pkey; Type: CONSTRAINT; Schema: common; Owner: -
--

ALTER TABLE ONLY common.continents
    ADD CONSTRAINT continents_pkey PRIMARY KEY (code);


--
-- Name: countries countries_name_key; Type: CONSTRAINT; Schema: common; Owner: -
--

ALTER TABLE ONLY common.countries
    ADD CONSTRAINT countries_name_key UNIQUE (name);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: common; Owner: -
--

ALTER TABLE ONLY common.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (code);


--
-- Name: currencies currencies_pkey; Type: CONSTRAINT; Schema: common; Owner: -
--

ALTER TABLE ONLY common.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (code);


--
-- Name: countries countries_continent_id_fkey; Type: FK CONSTRAINT; Schema: common; Owner: -
--

ALTER TABLE ONLY common.countries
    ADD CONSTRAINT countries_continent_id_fkey FOREIGN KEY (continent_id) REFERENCES common.continents(code);


--
-- Name: countries countries_default_currency_id_fkey; Type: FK CONSTRAINT; Schema: common; Owner: -
--

ALTER TABLE ONLY common.countries
    ADD CONSTRAINT countries_default_currency_id_fkey FOREIGN KEY (default_currency_id) REFERENCES common.currencies(code);


--
-- PostgreSQL database dump complete
--
