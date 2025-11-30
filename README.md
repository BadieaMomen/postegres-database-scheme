# postereSQL database schemes that replicate structure of postman:
this database schemes that replicate structure of postman
collections ,environments ,collections ,and workspaces ,requests ....


## atructure 
postman-database/
│
├── schema.sql -- All CREATE TABLE + constraints for the database
├── insert_data.sql -- 
└── erd.png -- Entity Relationship Diagram

## databbase overflow :
### **1 Users**
to Store users accounts 
|column   | type  | discription
|ID       |Int    |primary key and  unique 
|email    |varchar|string and unique 
|password |varchar|string and unique 
|creation |date   |use default now()

### **2. workspace**
Each user can create multiple workspaces.
| Column | Type | Description |
|--------|-------|-------------|
| id | SERIAL PK | Workspace ID |
| workname | varchar | Name of workspace |
| userid | int FK | Owner of the workspace |
| type | varchar | Workspace type (default: http) |
| access | varchar | Access level |

Relationship:  
**User (1) → (Many) Workspace**

---

### **3. Collections**
Collections belong to a workspace and group multiple requests.

| Column | Type | Description |
|--------|-------|-------------|
| id | SERIAL PK | Collection ID |
| name | varchar | Collection name |
| workspaceid | int FK | Workspace this belongs to |

Relationship:  
**Workspace (1) → (Many) Collections**

---

### **4. Methods**
List of HTTP methods (GET, POST,PATCH,DELETE,PUT)

| Column | Type | Description |
|--------|-------|-------------|
| id | SERIAL PK | Method ID |
| name | varchar | HTTP method name |

---

### **5. Requests**
Each request belongs to a collection and uses a method.

| Column | Type | Description |
|--------|-------|-------------|
| id | SERIAL PK | Request ID |
| name | varchar | Request name |
| url | text | API endpoint |
| methodid | int FK | HTTP method |
| collectionid | int FK | Collection |

Relationships:  
- **Collection (1) → (Many) Requests**  
- **Method (1) → (Many) Requests**

---

### **6. Headers**
Each request can have multiple key/value headers.

| Column | Type | Description |
|--------|-------|-------------|
| id | SERIAL PK | Header ID |
| requestid | int FK | Request |
| key | varchar | Header key |
| value | text | Header value |

Relationship:  
**Request (1) → (Many) Headers**

---

### **7. Body**
Each request may include a single request body (JSON, XML, text)

| Column | Type | Description |
|--------|-------|-------------|
| id | SERIAL PK | Body ID |
| request_id | int FK | Request |
| body_type | varchar | Body type |
| content | text | Body content |

Relationship:  
**Request (1) → (1) Body**

---

### **8. Responses**
Stores the responses received after executing requests (history).

| Column | Type | Description |
|--------|-------|-------------|
| id | SERIAL PK | Response ID |
| requestid | int FK | Request |
| status_code | int | HTTP status |
| response_time_ms | int | Response time |
| response_body | text | Response body content |

Relationship:  
**Request (1) → (Many) Responses**

### **9. Environment**
Stores variables used inside each workspace.

| Column | Type | Description |
|--------|-------|-------------|
| id | SERIAL PK | Env ID |
| workspaceid | int FK | Workspace |
| name | varchar | Environment name |
| key | varchar | Variable key |
| value | text | Variable value |

Relationship:  
**Workspace (1) → (Many) Environment Variables**

# ERD(ENTITY RELATIONSHAP DAIGRAM)

this is the erd that can help u to understand the scheme easily 
`ERD.png`