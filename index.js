const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const pdf = require('html-pdf-node');

const app = express();

// Middleware
app.use(cors({ origin: '*' }));
app.use(bodyParser.json({ limit: '10mb' }));

// 🔥 Basic PDF from root route
app.get('/', async (req, res) => {
  try {
    const file = {
      content: `
        <html>
          <body style="font-family: sans-serif;">
            <h1>Hello, my lord 👑</h1>
            <p>This is your auto-generated PDF from the root route.</p>
          </body>
        </html>
      `,
    };

    const pdfBuffer = await pdf.generatePdf(file, { format: 'A4' });
    res.setHeader('Content-Type', 'application/pdf');
    res.send(pdfBuffer);
  } catch (err) {
    console.error('Root PDF error:', err);
    res.status(500).json({ error: 'PDF generation failed' });
  }
});

// 📄 PDF generation endpoint
app.post('/generate-pdf', async (req, res) => {
  try {
    const { html } = req.body;

    if (!html) {
      return res.status(400).json({ error: 'HTML content is required' });
    }

    const file = { content: html };
    const pdfBuffer = await pdf.generatePdf(file, { format: 'A4' });

    res.setHeader('Content-Type', 'application/pdf');
    res.send(pdfBuffer);
  } catch (err) {
    console.error('PDF error:', err);
    res.status(500).json({ error: 'PDF generation failed' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`PDF service running on port ${PORT}`);
});
