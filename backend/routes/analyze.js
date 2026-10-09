const express = require('express');
const {
  resumeAnalysis,
  jobMatch,
  skillGap,
  roadmap,
  unifiedAnalysis
} = require('../controllers/analyzeController');
const { pdfUploadIfMultipart } = require('../middleware/upload');
const { requireAuth } = require('../middleware/requireAuth');

const router = express.Router();

// AI endpoints require a verified Supabase session (see requireAuth).
// Request/response contracts are unchanged.
router.post('/resume', requireAuth, pdfUploadIfMultipart, resumeAnalysis);
router.post('/job-match', requireAuth, pdfUploadIfMultipart, jobMatch);
router.post('/skill-gap', requireAuth, pdfUploadIfMultipart, skillGap);
router.post('/roadmap', requireAuth, pdfUploadIfMultipart, roadmap);

// Multipart for resume PDF OR JSON with resumeText. pdfUpload handles file validation.
// Every endpoint accepts both content types so the guided workflow can attach a PDF anywhere.
// (Auth stays enforced by the routes above — no unauthenticated duplicates.)

// Primary integrated analysis flow (modular endpoints above remain canonical).
router.post('/full', requireAuth, pdfUploadIfMultipart, unifiedAnalysis);

module.exports = router;

