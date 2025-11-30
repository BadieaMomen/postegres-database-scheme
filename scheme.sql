-- creating user table 
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    creationdate TIMESTAMP DEFAULT NOW()
);

-- workspace 

CREATE TABLE workspace (
    id SERIAL PRIMARY KEY,
    workname VARCHAR(255),
    userid INT,
    type VARCHAR(255) DEFAULT 'HTTP',
    access VARCHAR(255),
    CONSTRAINT fk_workspace_user
        FOREIGN KEY (userid) REFERENCES users(id)
        ON DELETE CASCADE
);

--  collections

CREATE TABLE collections (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    workspaceid INT,
    CONSTRAINT fk_collection_workspace
        FOREIGN KEY (workspaceid) REFERENCES workspace(id)
        ON DELETE CASCADE
);
-- methods 
CREATE TABLE methods (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20)
);

-- requeste 

CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    url TEXT,
    methodid INT,
    collectionid INT,
    CONSTRAINT fk_request_method
        FOREIGN KEY (methodid) REFERENCES methods(id),
    CONSTRAINT fk_request_collection
        FOREIGN KEY (collectionid) REFERENCES collections(id)
        ON DELETE CASCADE
);

-- header 

CREATE TABLE header (
    id SERIAL PRIMARY KEY,
    requestid INT,
    key VARCHAR(255),
    value TEXT,
    CONSTRAINT fk_header_request
        FOREIGN KEY (requestid) REFERENCES requests(id)
        ON DELETE CASCADE
);

-- body 
CREATE TABLE body (
    id SERIAL PRIMARY KEY,
    request_id INT,
    body_type VARCHAR(50),
    content TEXT,
    CONSTRAINT fk_body_request
        FOREIGN KEY (request_id) REFERENCES requests(id)
        ON DELETE CASCADE
);

-- respose 

CREATE TABLE responses (
    id SERIAL PRIMARY KEY,
    requestid INT,
    status_code INT,
    response_time_ms INT,
    response_body TEXT,
    CONSTRAINT fk_responses_request
        FOREIGN KEY (requestid) REFERENCES requests(id)
        ON DELETE CASCADE
);

-- environments 

CREATE TABLE environment (
    id SERIAL PRIMARY KEY,
    workspaceid INT,
    name VARCHAR(255),
    key VARCHAR(255),
    value TEXT,
    CONSTRAINT fk_environment_workspace
        FOREIGN KEY (workspaceid) REFERENCES workspace(id)
        ON DELETE CASCADE
);

