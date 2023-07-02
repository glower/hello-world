import express, { Request, Response } from 'express'
import axios, { AxiosResponse } from 'axios';

// backend service internal host
const backend = "hello-world-backend:8080"
const port = process.env.PORT || 8080
const app = express();

// getting data from backend service
const getData = async () => {
    let result: AxiosResponse = await axios.get(`http://${backend}/api/data`);
    let data = result.data;
    return data;
};

app.get('/ping', (_req: Request, res: Response) => {
    return res.send('pong 🏓')
})

// Serve the HTML page
app.get('/', async (req: Request, res: Response) => {
    try {
      const data = await getData();
      const message = data.message;
      res.send(`
        <!DOCTYPE html>
        <html>
          <head>
            <title>Hello World API Example</title>
          </head>
          <body>
            <h1>Hello World API Example</h1>
            <div id="response">${message}</div>
          </body>
        </html>
      `);
    } catch (error) {
      console.error('Error:', error);
      res.status(500).send('Internal Server Error');
    }
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
