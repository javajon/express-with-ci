const express = require('express');
const app = express();
const port = 8123;

// Define a route that returns "hello"
app.get('/', (req, res) => {
  res.send('Hello world!');
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});