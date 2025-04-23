CREATE TABLE IF NOT EXISTS public.categories
(
    "categoryID" integer NOT NULL,
    "categoryName" character varying COLLATE pg_catalog."default" NOT NULL,
    description character varying COLLATE pg_catalog."default",
    CONSTRAINT categories_pkey PRIMARY KEY ("categoryID")
)
