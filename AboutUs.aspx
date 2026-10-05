<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="PageTurnerBookstore.AboutUs" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .about-hero {
    background: linear-gradient(160deg, #2C1A14 0%, #3E2723 50%, #4E342E 100%);
    padding: 100px 60px;
    text-align: center;
    position: relative;
    overflow: hidden;
  }
  .about-hero::before { content: '📚'; position: absolute; font-size: 300px; opacity: 0.04; left: -50px; top: -50px; }
  .about-hero::after { content: '📖'; position: absolute; font-size: 300px; opacity: 0.04; right: -50px; bottom: -50px; }
  .about-hero-tag { display: inline-block; background: rgba(212,160,23,0.15); border: 1px solid rgba(212,160,23,0.4); color: #D4A017; padding: 6px 18px; border-radius: 30px; font-size: 12px; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 24px; }
  .about-hero h1 { font-family: 'Playfair Display', serif; font-size: 60px; font-weight: 900; color: #FDF6EC; margin-bottom: 20px; line-height: 1.1; }
  .about-hero h1 span { color: #D4A017; font-style: italic; }
  .about-hero p { font-family: 'Cormorant Garamond', serif; font-size: 24px; color: rgba(253,246,236,0.7); font-style: italic; max-width: 600px; margin: 0 auto; line-height: 1.6; }
  .about-wrapper { max-width: 1200px; margin: 0 auto; padding: 80px 60px; }
  .story-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 80px; align-items: center; margin-bottom: 80px; }
  .story-text h2 { font-family: 'Playfair Display', serif; font-size: 42px; color: #3E2723; margin-bottom: 20px; line-height: 1.1; }
  .story-text h2 span { color: #D4A017; font-style: italic; }
  .story-text p { font-size: 16px; color: #555; line-height: 1.9; margin-bottom: 16px; }
  .story-visual {
    border-radius: 24px;
    overflow: hidden;
    box-shadow: 0 20px 60px rgba(62,39,35,0.2);
    position: relative;
    height: 420px;
  }
  .story-visual img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }
  .story-visual-overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: linear-gradient(transparent, rgba(62,39,35,0.92));
    padding: 40px 36px 36px;
    text-align: center;
  }
  .story-visual-overlay h3 { font-family: 'Playfair Display', serif; font-size: 28px; color: #D4A017; margin-bottom: 12px; }
  .story-visual-overlay p { color: rgba(253,246,236,0.85); font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 17px; line-height: 1.7; }
  .values-section { margin-bottom: 80px; }
  .values-title { font-family: 'Playfair Display', serif; font-size: 38px; color: #3E2723; text-align: center; margin-bottom: 8px; }
  .values-title span { color: #D4A017; font-style: italic; }
  .values-sub { text-align: center; font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 20px; color: #8B5E3C; margin-bottom: 48px; }
  .values-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; }
  .value-card { background: white; border-radius: 20px; padding: 36px 28px; text-align: center; box-shadow: 0 4px 20px rgba(62,39,35,0.07); border: 1px solid rgba(212,160,23,0.12); transition: transform 0.3s; }
  .value-card:hover { transform: translateY(-6px); }
  .value-icon { font-size: 48px; margin-bottom: 16px; display: block; }
  .value-title { font-family: 'Playfair Display', serif; font-size: 22px; color: #3E2723; margin-bottom: 12px; }
  .value-desc { font-size: 15px; color: #6B4C3B; line-height: 1.7; }
  .stats-section { background: linear-gradient(135deg, #3E2723, #6D4C41); border-radius: 24px; padding: 60px; margin-bottom: 80px; border: 1px solid rgba(212,160,23,0.3); }
  .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; text-align: center; }
  .stat-item .num { font-family: 'Playfair Display', serif; font-size: 48px; font-weight: 700; color: #D4A017; display: block; }
  .stat-item .lbl { font-size: 13px; color: rgba(253,246,236,0.6); text-transform: uppercase; letter-spacing: 1px; margin-top: 4px; }
  .team-section { margin-bottom: 60px; }
  .team-title { font-family: 'Playfair Display', serif; font-size: 38px; color: #3E2723; text-align: center; margin-bottom: 8px; }
  .team-title span { color: #D4A017; font-style: italic; }
  .team-sub { text-align: center; font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 20px; color: #8B5E3C; margin-bottom: 48px; }
  .team-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; }
  .team-card { background: white; border-radius: 20px; padding: 36px 28px; text-align: center; box-shadow: 0 4px 20px rgba(62,39,35,0.07); border: 1px solid rgba(212,160,23,0.12); }
  .team-avatar { width: 90px; height: 90px; background: linear-gradient(135deg, #3E2723, #6D4C41); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; font-size: 40px; }
  .team-name { font-family: 'Playfair Display', serif; font-size: 20px; color: #3E2723; margin-bottom: 4px; }
  .team-role { font-size: 13px; color: #D4A017; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 12px; }
  .team-desc { font-size: 14px; color: #6B4C3B; line-height: 1.6; }
  .cta-section { background: linear-gradient(135deg, #FDF6EC, #F5E6D0); border-radius: 24px; padding: 60px; text-align: center; border: 1px solid rgba(212,160,23,0.2); }
  .cta-section h2 { font-family: 'Playfair Display', serif; font-size: 42px; color: #3E2723; margin-bottom: 16px; }
  .cta-section h2 span { color: #D4A017; font-style: italic; }
  .cta-section p { font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 22px; color: #8B5E3C; margin-bottom: 36px; }
  .cta-buttons { display: flex; gap: 16px; justify-content: center; }
  .btn-primary { display: inline-block; background: #3E2723; color: #D4A017; padding: 16px 40px; border-radius: 10px; font-size: 16px; font-weight: 700; text-decoration: none; transition: all 0.2s; }
  .btn-primary:hover { background: #D4A017; color: #3E2723; transform: translateY(-2px); }
  .btn-secondary { display: inline-block; background: transparent; color: #3E2723; padding: 16px 40px; border-radius: 10px; font-size: 16px; font-weight: 700; text-decoration: none; border: 2px solid #e8d5c0; transition: all 0.2s; }
  .btn-secondary:hover { border-color: #D4A017; color: #D4A017; }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <div class="about-hero">
    <div class="about-hero-tag">✨ Our Story</div>
    <h1>About <span>The Reading Nook</span></h1>
    <p>A cozy corner built by book lovers, for book lovers — right here in Malaysia.</p>
  </div>

  <div class="about-wrapper">

    <div class="story-grid">
      <div class="story-text">
        <h2>We believe every book<br/>deserves a <span>good home</span></h2>
        <p>The Reading Nook was born from a simple love of stories. We started as a small passion project and grew into Malaysia's most beloved online bookstore — one book at a time.</p>
        <p>Our carefully curated collection focuses on the world's most beloved book series — from the magical halls of Hogwarts to the sand dunes of Arrakis. We believe that great stories deserve to be in the hands of every reader.</p>
        <p>Based in Kuala Lumpur, we deliver across Malaysia with love, care and the occasional bookmark tucked inside your order. 😊</p>
      </div>
      <div class="story-visual">
        <img src="/Images/mission.jpg" alt="Our Mission" onerror="this.parentElement.style.background='linear-gradient(135deg,#3E2723,#6D4C41)'; this.style.display='none'"/>
        <div class="story-visual-overlay">
          <h3>Our Mission</h3>
          <p>"To connect every Malaysian reader with the stories that will change their lives — one book at a time."</p>
        </div>
      </div>
    </div>

    <div class="values-section">
      <div class="values-title">What We <span>Stand For</span></div>
      <div class="values-sub">The values that guide everything we do</div>
      <div class="values-grid">
        <div class="value-card">
          <span class="value-icon">❤️</span>
          <div class="value-title">Passion for Books</div>
          <div class="value-desc">Every book we carry is handpicked by our team of passionate readers who genuinely love what they sell.</div>
        </div>
        <div class="value-card">
          <span class="value-icon">🚀</span>
          <div class="value-title">Fast Delivery</div>
          <div class="value-desc">We know you can't wait to start reading. That's why we deliver across Malaysia as fast as possible.</div>
        </div>
        <div class="value-card">
          <span class="value-icon">💎</span>
          <div class="value-title">Quality First</div>
          <div class="value-desc">Every book arrives in perfect condition, carefully packed to ensure your reading experience starts right.</div>
        </div>
        <div class="value-card">
          <span class="value-icon">🤝</span>
          <div class="value-title">Customer Care</div>
          <div class="value-desc">Our team is always here to help. We treat every customer like a fellow book lover — because you are!</div>
        </div>
        <div class="value-card">
          <span class="value-icon">🌿</span>
          <div class="value-title">Sustainability</div>
          <div class="value-desc">We use eco-friendly packaging and are committed to reducing our environmental footprint.</div>
        </div>
        <div class="value-card">
          <span class="value-icon">🌍</span>
          <div class="value-title">Community</div>
          <div class="value-desc">We're building a community of readers across Malaysia who share the magic of great stories.</div>
        </div>
      </div>
    </div>

    <div class="stats-section">
      <div class="stats-grid">
        <div class="stat-item">
          <span class="num">53+</span>
          <span class="lbl">Books Available</span>
        </div>
        <div class="stat-item">
          <span class="num">11</span>
          <span class="lbl">Book Series</span>
        </div>
        <div class="stat-item">
          <span class="num">6</span>
          <span class="lbl">Genres</span>
        </div>
        <div class="stat-item">
          <span class="num">🇲🇾</span>
          <span class="lbl">Malaysia Wide</span>
        </div>
      </div>
    </div>

    <div class="team-section">
      <div class="team-title">Meet the <span>Team</span></div>
      <div class="team-sub">The book lovers behind The Reading Nook</div>
      <div class="team-grid">
        <div class="team-card">
          <div class="team-avatar">👩</div>
          <div class="team-name">Azeeza</div>
          <div class="team-role">Founder & CEO</div>
          <div class="team-desc">A lifelong bookworm who turned her passion into Malaysia's coziest online bookstore.</div>
        </div>
        <div class="team-card">
          <div class="team-avatar">👨</div>
          <div class="team-name">Shabalala</div>
          <div class="team-role">Head of Curation</div>
          <div class="team-desc">Reads over 100 books a year and handpicks every title in our collection.</div>
        </div>
        <div class="team-card">
          <div class="team-avatar">👩</div>
          <div class="team-name">Zee</div>
          <div class="team-role">Customer Experience</div>
          <div class="team-desc">Makes sure every customer feels welcome and every order arrives with a smile.</div>
        </div>
      </div>
    </div>

    <div class="cta-section">
      <h2>Ready to find your next<br/><span>great story?</span></h2>
      <p>Browse our collection of 53+ books across 11 beloved series</p>
      <div class="cta-buttons">
        <a href="/BookList.aspx" class="btn-primary">Browse All Books →</a>
        <a href="/Register.aspx" class="btn-secondary">Create Account</a>
      </div>
    </div>

  </div>
</asp:Content>