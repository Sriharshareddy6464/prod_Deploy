from fastapi import FastAPI, UploadFile, File

app = FastAPI()

@app.get("/")
def read_root():
    return {"status": "ProdDeploy API is running"}

@app.post("/upload")
async def upload_file(file: UploadFile = File(...)):
    content = await file.read()
    size = len(content)
    return {
        "filename": file.filename,
        "size_bytes": size,
        "message": "File received successfully"
    }
