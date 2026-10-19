CREATE TABLE members (
   id        INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   full_name VARCHAR(100) NOT NULL,
   email     VARCHAR(150) NOT NULL UNIQUE,
   joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE courses (
   id       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   title    VARCHAR(200) NOT NULL,
   capacity INT NOT NULL CHECK (capacity > 0)
);

CREATE TABLE registrations (
   id            INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   member_id     INT NOT NULL REFERENCES members(id),
   course_id     INT NOT NULL REFERENCES courses(id),
   status        VARCHAR(20) NOT NULL DEFAULT 'pending',
   registered_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
   UNIQUE (member_id, course_id)
);
CREATE INDEX ix_reg_course ON registrations (course_id);

INSERT INTO members (full_name, email) VALUES
  ('Nguyễn An', 'an@dthu.edu.vn'),
  ('Trần Bình', 'binh@dthu.edu.vn'),
  ('Lê Chi',    'chi@dthu.edu.vn');

INSERT INTO courses (title, capacity) VALUES
  ('Lập trình Web', 2), ('Cơ sở dữ liệu', 40);

INSERT INTO registrations (member_id, course_id)
  VALUES (1, 1), (1, 2), (2, 1);