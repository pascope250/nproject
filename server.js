// const { createServer } = require('http');
// const next = require('next');
// const { Server: SocketServer } = require('socket.io');

// const dev = process.env.NODE_ENV !== 'production';
// const app = next({ dev });
// const handle = app.getRequestHandler();

// app.prepare().then(() => {
//   const server = createServer((req, res) => {
//     handle(req, res);
//   });

//   const io = new SocketServer(server);

//   // Make io accessible globally
//   global.io = io;

//   io.on('connection', (socket) => {
//     console.log('Client connected:', socket.id);
    
//     socket.on('disconnect', () => {
//       console.log('Client disconnected:', socket.id);
//     });
//   });

//   server.listen(3001, (err) => {
//     if (err) throw err;
//     console.log('> Ready on http://localhost:3001');
//   });
// });




const { createServer } = require('http');
const next = require('next');
const { Server: SocketServer } = require('socket.io');

const dev = process.env.NODE_ENV !== 'production';
const app = next({ dev });
const handle = app.getRequestHandler();

// Global variable to store io instance
global.io = null;

app.prepare().then(() => {
  const server = createServer((req, res) => {
    // Attach io to request object for API routes
    req.io = global.io;
    handle(req, res);
  });

  // Initialize Socket.io
  const io = new SocketServer(server, {
    cors: {
      origin: dev ? 'http://localhost:3000' : 'https://your-production-domain.com',
      methods: ['GET', 'POST']
    },
    path: '/api/socketio',
    serveClient: false,
    pingTimeout: 10000,
    pingInterval: 5000
  });

  // Store io instance globally
  global.io = io;

  // Socket.io connection handler
  io.on('connection', (socket) => {
    console.log('Client connected:', socket.id);
     // Disconnect if too many connections from same origin
  const connections = Array.from(io.sockets.sockets.values())
    .filter(s => s.handshake.headers.origin === socket.handshake.headers.origin);
  
  if (connections.length > 3) { // Adjust threshold
    socket.disconnect(true);
    return;
  }
    socket.on('disconnect', () => {
      console.log('Client disconnected:', socket.id);
    });
  });

  const port = process.env.PORT || 3001;
  server.listen(port, (err) => {
    if (err) throw err;
    console.log(`> Ready on http://localhost:${port}`);
  });
});