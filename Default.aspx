<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PageTurnerBookstore._Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .hero {
    min-height: 92vh;
    background: radial-gradient(ellipse at 70% 50%, rgba(212,160,23,0.08) 0%, transparent 60%),
      linear-gradient(160deg, #2C1A14 0%, #3E2723 40%, #4E342E 70%, #3E2723 100%);
    display: flex;
    align-items: center;
    padding: 0 60px;
    position: relative;
    overflow: hidden;
  }
  .hero::before {
    content: '';
    position: absolute;
    inset: 0;
    background-image:
      repeating-linear-gradient(0deg, transparent, transparent 80px, rgba(212,160,23,0.03) 80px, rgba(212,160,23,0.03) 81px),
      repeating-linear-gradient(90deg, transparent, transparent 80px, rgba(212,160,23,0.03) 80px, rgba(212,160,23,0.03) 81px);
  }
  .hero-left { flex: 1; z-index: 2; animation: fadeInUp 0.8s ease both; }
  @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
  .hero-tag { display: inline-block; background: rgba(212,160,23,0.15); border: 1px solid rgba(212,160,23,0.4); color: #D4A017; padding: 6px 18px; border-radius: 30px; font-size: 12px; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 24px; }
  .hero h1 { font-family: 'Playfair Display', serif; font-size: 72px; font-weight: 900; color: #FDF6EC; line-height: 1.05; margin-bottom: 12px; }
  .hero h1 span { color: #D4A017; font-style: italic; }
  .hero-sub { font-family: 'Cormorant Garamond', serif; font-size: 22px; color: rgba(253,246,236,0.65); font-style: italic; margin-bottom: 40px; line-height: 1.5; max-width: 480px; }
  .hero-buttons { display: flex; gap: 16px; }
  .btn-primary { background: #D4A017; color: #3E2723; padding: 16px 36px; border-radius: 8px; font-weight: 700; font-size: 15px; text-decoration: none; transition: all 0.2s; box-shadow: 0 4px 20px rgba(212,160,23,0.3); }
  .btn-primary:hover { background: #F0C040; transform: translateY(-2px); }
  .btn-secondary { background: transparent; color: #FDF6EC; padding: 16px 36px; border-radius: 8px; font-weight: 600; font-size: 15px; text-decoration: none; border: 1px solid rgba(253,246,236,0.3); transition: all 0.2s; }
  .btn-secondary:hover { border-color: #D4A017; color: #D4A017; }
  .hero-stats { display: flex; gap: 40px; margin-top: 60px; padding-top: 40px; border-top: 1px solid rgba(212,160,23,0.2); }
  .stat-num { font-family: 'Playfair Display', serif; font-size: 36px; font-weight: 700; color: #D4A017; display: block; }
  .stat-label { font-size: 12px; color: rgba(253,246,236,0.5); text-transform: uppercase; letter-spacing: 1px; }
  .hero-right { flex: 0.8; display: flex; justify-content: center; align-items: center; height: 500px; z-index: 2; }
  .floating-books { position: relative; width: 380px; height: 460px; }
  .fbook { position: absolute; border-radius: 12px; padding: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.5); animation: float 6s ease-in-out infinite; }
  .fbook-1 { width: 180px; background: linear-gradient(135deg, #1a1a2e, #16213e); border: 1px solid rgba(212,160,23,0.3); top: 0; left: 0; animation-delay: 0s; }
  .fbook-2 { width: 180px; background: linear-gradient(135deg, #2d1b0e, #4a2c16); border: 1px solid rgba(212,160,23,0.4); top: 60px; right: 0; animation-delay: -2s; }
  .fbook-3 { width: 160px; background: linear-gradient(135deg, #1a2e1a, #2d4a2d); border: 1px solid rgba(100,200,100,0.3); bottom: 20px; left: 40px; animation-delay: -4s; }
  @keyframes float { 0%, 100% { transform: translateY(0px) rotate(-1deg); } 50% { transform: translateY(-15px) rotate(1deg); } }
  .fbook-genre { font-size: 9px; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase; color: #D4A017; margin-bottom: 10px; }
  .fbook-title { font-family: 'Playfair Display', serif; font-size: 14px; color: #FDF6EC; font-weight: 700; line-height: 1.3; margin-bottom: 6px; }
  .fbook-author { font-size: 11px; color: rgba(253,246,236,0.5); font-style: italic; }
  .fbook-price { margin-top: 12px; font-size: 18px; font-weight: 700; color: #D4A017; }
  .home-section { padding: 80px 60px 0; max-width: 1300px; margin: 0 auto; }
  .section-header { display: flex; align-items: flex-end; justify-content: space-between; margin-bottom: 40px; }
  .section-title { font-family: 'Playfair Display', serif; font-size: 38px; font-weight: 700; color: #3E2723; line-height: 1.1; }
  .section-title span { color: #D4A017; font-style: italic; }
  .section-sub { font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 18px; color: #6B4C3B; margin-top: 6px; }
  .see-all { color: #8B5E3C; text-decoration: none; font-size: 13px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; border-bottom: 2px solid #D4A017; padding-bottom: 2px; transition: color 0.2s; white-space: nowrap; }
  .see-all:hover { color: #D4A017; }
  .series-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
  .series-card { background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 20px rgba(62,39,35,0.08); transition: transform 0.3s, box-shadow 0.3s; border: 1px solid rgba(212,160,23,0.15); text-decoration: none; display: block; }
  .series-card:hover { transform: translateY(-6px); box-shadow: 0 16px 40px rgba(62,39,35,0.15); }
  .series-card-img { height: 200px; display: flex; align-items: center; justify-content: center; font-size: 56px; position: relative; overflow: hidden; }
  .series-card-img img { width: 100%; height: 100%; object-fit: cover; display: block; }
  .sc-hp { background: linear-gradient(135deg, #1a1a3e, #2d2d6b); }
  .sc-hg { background: linear-gradient(135deg, #2d0a0a, #6b1a1a); }
  .sc-pj { background: linear-gradient(135deg, #0a1a3e, #1a3a6b); }
  .sc-ac { background: linear-gradient(135deg, #2d0a1a, #6b1a3a); }
  .series-card-body { padding: 16px; }
  .series-card-name { font-family: 'Playfair Display', serif; font-size: 16px; font-weight: 700; color: #3E2723; margin-bottom: 4px; }
  .series-card-author { font-size: 12px; color: #6B4C3B; font-style: italic; margin-bottom: 10px; }
  .series-card-meta { display: flex; justify-content: space-between; align-items: center; }
  .sc-badge { background: rgba(212,160,23,0.15); color: #8B5E3C; padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; }
  .sc-books { font-size: 11px; color: #6B4C3B; }
  .genre-strip { background: #3E2723; padding: 60px; margin: 80px 0 0 0; }
  .genre-strip .section-title { color: #D4A017; }
  .genre-strip .section-sub { color: rgba(253,246,236,0.6); }
  .genre-pills { display: flex; gap: 12px; flex-wrap: wrap; margin-top: 30px; }
  .genre-pill { background: rgba(255,255,255,0.06); border: 1px solid rgba(212,160,23,0.25); color: rgba(253,246,236,0.85); padding: 12px 28px; border-radius: 50px; font-size: 14px; font-weight: 600; transition: all 0.2s; text-decoration: none; display: inline-block; }
  .genre-pill:hover { background: #D4A017; color: #3E2723; border-color: #D4A017; transform: translateY(-2px); }
  .books-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 24px; }
  .book-card { background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 20px rgba(62,39,35,0.07); transition: transform 0.3s, box-shadow 0.3s; border: 1px solid rgba(212,160,23,0.12); text-decoration: none; display: block; }
  .book-card:hover { transform: translateY(-6px); box-shadow: 0 16px 40px rgba(62,39,35,0.14); }
  .book-cover { height: 200px; display: flex; align-items: center; justify-content: center; font-size: 60px; position: relative; overflow: hidden; }
  .book-cover img { width: 100%; height: 100%; object-fit: cover; display: block; }
  .bc-1 { background: linear-gradient(135deg, #1a1a3e, #4a4a9e); }
  .bc-2 { background: linear-gradient(135deg, #3e1a1a, #9e4a4a); }
  .bc-3 { background: linear-gradient(135deg, #1a3e1a, #4a9e4a); }
  .bc-4 { background: linear-gradient(135deg, #3e2d1a, #9e7a4a); }
  .book-badge { position: absolute; top: 12px; right: 12px; background: #D4A017; color: #3E2723; padding: 3px 10px; border-radius: 20px; font-size: 10px; font-weight: 700; text-transform: uppercase; z-index: 1; }
  .book-body { padding: 18px; }
  .book-series { font-size: 10px; font-weight: 700; color: #D4A017; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 6px; }
  .book-title { font-family: 'Playfair Display', serif; font-size: 15px; font-weight: 700; color: #3E2723; margin-bottom: 4px; line-height: 1.3; }
  .book-author { font-size: 12px; color: #6B4C3B; font-style: italic; margin-bottom: 12px; }
  .book-footer { display: flex; justify-content: space-between; align-items: center; }
  .book-price { font-size: 20px; font-weight: 700; color: #3E2723; }
  .book-price small { font-size: 12px; color: #6B4C3B; font-weight: 400; display: block; }
  .add-btn { background: #3E2723; color: #D4A017; border: none; width: 36px; height: 36px; border-radius: 50%; font-size: 20px; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: all 0.2s; text-decoration: none; }
  .add-btn:hover { background: #D4A017; color: #3E2723; }
  .promo-wrap { padding: 60px; max-width: 1300px; margin: 0 auto; }
  .promo-banner { background: linear-gradient(135deg, #3E2723, #6D4C41); border-radius: 24px; padding: 50px 60px; display: flex; align-items: center; justify-content: space-between; border: 1px solid rgba(212,160,23,0.3); position: relative; overflow: hidden; }
  .promo-banner::before { content: '📚'; position: absolute; right: 200px; font-size: 150px; opacity: 0.08; }
  .promo-text h2 { font-family: 'Playfair Display', serif; font-size: 36px; color: #D4A017; margin-bottom: 10px; }
  .promo-text p { color: rgba(253,246,236,0.75); font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 20px; }
  .promo-btn { background: #D4A017; color: #3E2723; padding: 16px 40px; border-radius: 8px; font-weight: 700; font-size: 15px; text-decoration: none; transition: all 0.2s; box-shadow: 0 4px 20px rgba(212,160,23,0.3); white-space: nowrap; }
  .promo-btn:hover { background: #F0C040; transform: translateY(-2px); }

  /* CINEMATIC AD BANNER */
  .ad-banner-section { position: relative; width: 100%; height: 400px; overflow: hidden; margin-top: 0; }
  .ad-slide { position: absolute; inset: 0; opacity: 0; transition: opacity 0.8s ease; display: flex; align-items: center; }
  .ad-slide.active { opacity: 1; }
  .ad-slide-bg { position: absolute; inset: 0; background-size: cover; background-position: center; filter: brightness(0.3); transition: transform 8s ease; transform: scale(1.05); }
  .ad-slide.active .ad-slide-bg { transform: scale(1); }
  .ad-slide-content { position: relative; z-index: 2; display: flex; align-items: center; gap: 60px; padding: 0 80px; width: 100%; }
  .ad-book-cover { width: 180px; height: 260px; border-radius: 12px; object-fit: cover; box-shadow: 0 30px 80px rgba(0,0,0,0.6); transform: perspective(800px) rotateY(-5deg); transition: transform 0.3s; flex-shrink: 0; }
  .ad-book-cover:hover { transform: perspective(800px) rotateY(0deg) scale(1.03); }
  .ad-text { flex: 1; }
  .ad-tag { display: inline-block; background: rgba(212,160,23,0.25); border: 1px solid rgba(212,160,23,0.5); color: #D4A017; padding: 5px 16px; border-radius: 20px; font-size: 11px; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 16px; }
  .ad-book-title { font-family: 'Playfair Display', serif; font-size: 48px; font-weight: 900; color: #FDF6EC; line-height: 1.1; margin-bottom: 12px; text-shadow: 0 2px 20px rgba(0,0,0,0.5); }
  .ad-book-author { font-family: 'Cormorant Garamond', serif; font-size: 22px; color: rgba(253,246,236,0.7); font-style: italic; margin-bottom: 24px; }
  .ad-cta { display: inline-block; background: #D4A017; color: #3E2723; padding: 14px 32px; border-radius: 8px; font-weight: 700; font-size: 15px; text-decoration: none; transition: all 0.2s; box-shadow: 0 4px 20px rgba(212,160,23,0.4); }
  .ad-cta:hover { background: #F0C040; transform: translateY(-2px); }
  .ad-dots { position: absolute; bottom: 20px; left: 50%; transform: translateX(-50%); display: flex; gap: 8px; z-index: 3; }
  .ad-dot { width: 8px; height: 8px; border-radius: 50%; background: rgba(255,255,255,0.4); cursor: pointer; transition: all 0.3s; border: none; }
  .ad-dot.active { background: #D4A017; width: 24px; border-radius: 4px; }
  .ad-nav { position: absolute; top: 50%; transform: translateY(-50%); z-index: 3; background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); color: white; width: 44px; height: 44px; border-radius: 50%; cursor: pointer; font-size: 18px; display: flex; align-items: center; justify-content: center; transition: all 0.2s; backdrop-filter: blur(10px); }
  .ad-nav:hover { background: #D4A017; color: #3E2723; border-color: #D4A017; }
  .ad-nav-prev { left: 20px; }
  .ad-nav-next { right: 20px; }
  .ad-xml-badge { position: absolute; top: 16px; right: 16px; background: rgba(0,0,0,0.5); border: 1px solid rgba(212,160,23,0.4); color: #D4A017; padding: 4px 12px; border-radius: 20px; font-size: 10px; font-weight: 700; letter-spacing: 1px; z-index: 3; backdrop-filter: blur(10px); }
  .hidden-rotator { display: none; }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <!-- HERO -->
  <section class="hero">
    <div class="hero-left">
      <div class="hero-tag">✨ Malaysia's Coziest Bookstore</div>
      <h1>Find Your Next<br/><span>Great Story</span></h1>
      <p class="hero-sub">From magical worlds to dystopian futures — every book is a new adventure waiting for you.</p>
      <div class="hero-buttons">
        <a href="/BookList.aspx" class="btn-primary">Browse All Books</a>
        <a href="/SeriesCatalog.aspx" class="btn-secondary">Explore Series →</a>
      </div>
      <div class="hero-stats">
        <div><span class="stat-num">53+</span><span class="stat-label">Books Available</span></div>
        <div><span class="stat-num">11</span><span class="stat-label">Book Series</span></div>
        <div><span class="stat-num">6</span><span class="stat-label">Genres</span></div>
      </div>
    </div>
    <div class="hero-right">
      <div class="floating-books">
        <div class="fbook fbook-1">
          <div class="fbook-genre">Fantasy</div>
          <div class="fbook-title">Harry Potter & the Philosopher's Stone</div>
          <div class="fbook-author">by J.K. Rowling</div>
          <div class="fbook-price">RM 49.90</div>
        </div>
        <div class="fbook fbook-2">
          <div class="fbook-genre">Dystopian</div>
          <div class="fbook-title">The Hunger Games</div>
          <div class="fbook-author">by Suzanne Collins</div>
          <div class="fbook-price">RM 42.90</div>
        </div>
        <div class="fbook fbook-3">
          <div class="fbook-genre">Fantasy</div>
          <div class="fbook-title">The Lightning Thief</div>
          <div class="fbook-author">by Rick Riordan</div>
          <div class="fbook-price">RM 44.90</div>
        </div>
      </div>
    </div>
  </section>

  <!-- HIDDEN AD ROTATOR (XML powered) -->
  <div class="hidden-rotator">
    <asp:AdRotator ID="adRotator" runat="server"
      AdvertisementFile="~/XML/ads.xml"/>
  </div>

  <!-- CINEMATIC AD BANNER (reads from ads.xml via code-behind) -->
  <div class="ad-banner-section" id="adBanner">

    <div class="ad-slide active" id="slide0">
      <div class="ad-slide-bg" style="background-image:url('/Images/hp1.jpg')"></div>
      <div class="ad-slide-content">
        <img src="/Images/hp1.jpg" class="ad-book-cover" alt="Harry Potter"/>
        <div class="ad-text">
          <span class="ad-tag">⚡ Fantasy · Featured</span>
          <div class="ad-book-title">Harry Potter &amp;<br/>the Philosopher's Stone</div>
          <div class="ad-book-author">by J.K. Rowling</div>
          <a href="/BookDetail.aspx?id=B001" class="ad-cta">View Book →</a>
        </div>
      </div>
    </div>

    <div class="ad-slide" id="slide1">
      <div class="ad-slide-bg" style="background-image:url('/Images/hg1.jpg')"></div>
      <div class="ad-slide-content">
        <img src="/Images/hg1.jpg" class="ad-book-cover" alt="Hunger Games"/>
        <div class="ad-text">
          <span class="ad-tag">🔥 Dystopian · Featured</span>
          <div class="ad-book-title">The Hunger<br/>Games</div>
          <div class="ad-book-author">by Suzanne Collins</div>
          <a href="/BookDetail.aspx?id=B008" class="ad-cta">View Book →</a>
        </div>
      </div>
    </div>

    <div class="ad-slide" id="slide2">
      <div class="ad-slide-bg" style="background-image:url('/Images/acotar1.jpg')"></div>
      <div class="ad-slide-content">
        <img src="/Images/acotar1.jpg" class="ad-book-cover" alt="ACOTAR"/>
        <div class="ad-text">
          <span class="ad-tag">💕 Romance · Featured</span>
          <div class="ad-book-title">A Court of Thorns<br/>and Roses</div>
          <div class="ad-book-author">by Sarah J. Maas</div>
          <a href="/BookDetail.aspx?id=B038" class="ad-cta">View Book →</a>
        </div>
      </div>
    </div>

    <div class="ad-slide" id="slide3">
      <div class="ad-slide-bg" style="background-image:url('/Images/dune1.jpg')"></div>
      <div class="ad-slide-content">
        <img src="/Images/dune1.jpg" class="ad-book-cover" alt="Dune"/>
        <div class="ad-text">
          <span class="ad-tag">🚀 Sci-Fi · Featured</span>
          <div class="ad-book-title">Dune</div>
          <div class="ad-book-author">by Frank Herbert</div>
          <a href="/BookDetail.aspx?id=B043" class="ad-cta">View Book →</a>
        </div>
      </div>
    </div>

    <div class="ad-slide" id="slide4">
      <div class="ad-slide-bg" style="background-image:url('/Images/pj1.jpg')"></div>
      <div class="ad-slide-content">
        <img src="/Images/pj1.jpg" class="ad-book-cover" alt="Percy Jackson"/>
        <div class="ad-text">
          <span class="ad-tag">⚡ Fantasy · Featured</span>
          <div class="ad-book-title">The Lightning<br/>Thief</div>
          <div class="ad-book-author">by Rick Riordan</div>
          <a href="/BookDetail.aspx?id=B016" class="ad-cta">View Book →</a>
        </div>
      </div>
    </div>

    <button class="ad-nav ad-nav-prev" onclick="changeSlide(-1)">‹</button>
    <button class="ad-nav ad-nav-next" onclick="changeSlide(1)">›</button>

    <div class="ad-dots">
      <button class="ad-dot active" onclick="goToSlide(0)"></button>
      <button class="ad-dot" onclick="goToSlide(1)"></button>
      <button class="ad-dot" onclick="goToSlide(2)"></button>
      <button class="ad-dot" onclick="goToSlide(3)"></button>
      <button class="ad-dot" onclick="goToSlide(4)"></button>
    </div>
  </div>

  <!-- POPULAR SERIES -->
  <div class="home-section">
    <div class="section-header">
      <div>
        <div class="section-title">Popular <span>Series</span></div>
        <div class="section-sub">Complete your collection today</div>
      </div>
      <a href="/SeriesCatalog.aspx" class="see-all">View All Series →</a>
    </div>
    <div class="series-grid">
      <a href="/BookList.aspx?series=Harry+Potter" class="series-card">
        <div class="series-card-img sc-hp">
          <img src="/Images/series-hp.jpg" onerror="this.style.display='none'"/>
        </div>
        <div class="series-card-body">
          <div class="series-card-name">Harry Potter</div>
          <div class="series-card-author">by J.K. Rowling</div>
          <div class="series-card-meta">
            <span class="sc-badge">Fantasy</span>
            <span class="sc-books">7 Books</span>
          </div>
        </div>
      </a>
      <a href="/BookList.aspx?series=Hunger+Games" class="series-card">
        <div class="series-card-img sc-hg">
          <img src="/Images/series-hg.jpg" onerror="this.style.display='none'"/>
        </div>
        <div class="series-card-body">
          <div class="series-card-name">Hunger Games</div>
          <div class="series-card-author">by Suzanne Collins</div>
          <div class="series-card-meta">
            <span class="sc-badge">Dystopian</span>
            <span class="sc-books">3 Books</span>
          </div>
        </div>
      </a>
      <a href="/BookList.aspx?series=Percy+Jackson" class="series-card">
        <div class="series-card-img sc-pj">
          <img src="/Images/series-pj.jpg" onerror="this.style.display='none'"/>
        </div>
        <div class="series-card-body">
          <div class="series-card-name">Percy Jackson</div>
          <div class="series-card-author">by Rick Riordan</div>
          <div class="series-card-meta">
            <span class="sc-badge">Fantasy</span>
            <span class="sc-books">5 Books</span>
          </div>
        </div>
      </a>
      <a href="/BookList.aspx?series=ACOTAR" class="series-card">
        <div class="series-card-img sc-ac">
          <img src="/Images/series-acotar.jpg" onerror="this.style.display='none'"/>
        </div>
        <div class="series-card-body">
          <div class="series-card-name">ACOTAR</div>
          <div class="series-card-author">by Sarah J. Maas</div>
          <div class="series-card-meta">
            <span class="sc-badge">Romance</span>
            <span class="sc-books">5 Books</span>
          </div>
        </div>
      </a>
    </div>
  </div>

    <!-- QUIZ BANNER -->
<div style="max-width:1300px; margin:80px auto 0; padding:0 60px;">
  <div style="background:linear-gradient(135deg,#1a1a3e,#2d2d6b); border-radius:24px; padding:50px 60px; display:flex; align-items:center; justify-content:space-between; position:relative; overflow:hidden; border:1px solid rgba(212,160,23,0.3);">
    <div style="position:absolute;right:40px;top:-20px;font-size:150px;opacity:0.06;">🎯</div>
    <div style="z-index:1;">
      <div style="display:inline-block;background:rgba(212,160,23,0.2);border:1px solid rgba(212,160,23,0.4);color:#D4A017;padding:4px 14px;border-radius:20px;font-size:11px;font-weight:700;letter-spacing:2px;margin-bottom:16px;">✨ NEW FEATURE</div>
      <h2 style="font-family:'Playfair Display',serif;font-size:36px;color:#FDF6EC;margin-bottom:10px;">Not sure what to read <span style="color:#D4A017;font-style:italic;">next?</span></h2>
      <p style="font-family:'Cormorant Garamond',serif;font-style:italic;font-size:20px;color:rgba(253,246,236,0.7);">Answer 5 quick questions and we'll find your perfect book match!</p>
    </div>
    <a href="/BookQuiz.aspx" style="flex-shrink:0;background:#D4A017;color:#3E2723;padding:18px 40px;border-radius:12px;font-size:16px;font-weight:700;text-decoration:none;transition:all 0.2s;box-shadow:0 4px 20px rgba(212,160,23,0.4);z-index:1;white-space:nowrap;">
      🎯 Take the Quiz →
    </a>
  </div>
</div>

  <!-- GENRE STRIP -->
  <div class="genre-strip">
    <div style="max-width:1300px; margin:0 auto;">
      <div class="section-title">Browse by <span style="color:#FDF6EC; font-style:italic;">Genre</span></div>
      <div class="section-sub">Find exactly what you're in the mood for</div>
      <div class="genre-pills">
        <a href="/BookList.aspx" class="genre-pill">📚 All Books</a>
        <a href="/BookList.aspx?genre=Fantasy" class="genre-pill">⚡ Fantasy</a>
        <a href="/BookList.aspx?genre=Dystopian" class="genre-pill">🔥 Dystopian</a>
        <a href="/BookList.aspx?genre=Romance" class="genre-pill">💕 Romance</a>
        <a href="/BookList.aspx?genre=Sci-Fi" class="genre-pill">🚀 Sci-Fi</a>
        <a href="/BookList.aspx?genre=Children" class="genre-pill">🌟 Children</a>
        <a href="/BookList.aspx?genre=Classic" class="genre-pill">📖 Classic</a>
        <a href="/BookList.aspx?genre=Self-Help" class="genre-pill">💡 Self-Help</a>
      </div>
    </div>
  </div>

  <!-- FEATURED BOOKS -->
  <div class="home-section">
    <div class="section-header">
      <div>
        <div class="section-title">Featured <span>Books</span></div>
        <div class="section-sub">Handpicked just for you</div>
      </div>
      <a href="/BookList.aspx" class="see-all">View All Books →</a>
    </div>
    <div class="books-grid">
      <a href="/BookDetail.aspx?id=B001" class="book-card">
        <div class="book-cover bc-1">
          <img src="/Images/hp1.jpg" onerror="this.style.display='none'"/>
          <span class="book-badge">Bestseller</span>
        </div>
        <div class="book-body">
          <div class="book-series">Harry Potter</div>
          <div class="book-title">The Philosopher's Stone</div>
          <div class="book-author">by J.K. Rowling</div>
          <div class="book-footer">
            <div class="book-price">RM 49.90<small>In Stock</small></div>
            <span class="add-btn">+</span>
          </div>
        </div>
      </a>
      <a href="/BookDetail.aspx?id=B008" class="book-card">
        <div class="book-cover bc-2">
          <img src="/Images/hg1.jpg" onerror="this.style.display='none'"/>
          <span class="book-badge">Popular</span>
        </div>
        <div class="book-body">
          <div class="book-series">Hunger Games</div>
          <div class="book-title">The Hunger Games</div>
          <div class="book-author">by Suzanne Collins</div>
          <div class="book-footer">
            <div class="book-price">RM 42.90<small>In Stock</small></div>
            <span class="add-btn">+</span>
          </div>
        </div>
      </a>
      <a href="/BookDetail.aspx?id=B016" class="book-card">
        <div class="book-cover bc-3">
          <img src="/Images/pj1.jpg" onerror="this.style.display='none'"/>
          <span class="book-badge">Top Pick</span>
        </div>
        <div class="book-body">
          <div class="book-series">Percy Jackson</div>
          <div class="book-title">The Lightning Thief</div>
          <div class="book-author">by Rick Riordan</div>
          <div class="book-footer">
            <div class="book-price">RM 44.90<small>In Stock</small></div>
            <span class="add-btn">+</span>
          </div>
        </div>
      </a>
      <a href="/BookDetail.aspx?id=B038" class="book-card">
        <div class="book-cover bc-4">
          <img src="/Images/acotar1.jpg" onerror="this.style.display='none'"/>
          <span class="book-badge">New</span>
        </div>
        <div class="book-body">
          <div class="book-series">ACOTAR</div>
          <div class="book-title">A Court of Thorns and Roses</div>
          <div class="book-author">by Sarah J. Maas</div>
          <div class="book-footer">
            <div class="book-price">RM 54.90<small>In Stock</small></div>
            <span class="add-btn">+</span>
          </div>
        </div>
      </a>
    </div>
  </div>

  <!-- PROMO BANNER -->
  <div class="promo-wrap">
    <div class="promo-banner">
      <div class="promo-text">
        <h2>Start Your Collection Today</h2>
        <p>Free shipping on orders above RM 100 • Malaysia wide delivery</p>
      </div>
      <a href="/BookList.aspx" class="promo-btn">Shop Now →</a>
    </div>
  </div>

  <script>
    let currentSlide = 0;
    const totalSlides = 5;
    let autoPlay = setInterval(() => changeSlide(1), 4000);

    function changeSlide(dir) {
      goToSlide((currentSlide + dir + totalSlides) % totalSlides);
    }

    function goToSlide(n) {
      document.querySelectorAll('.ad-slide').forEach((s, i) => {
        s.classList.toggle('active', i === n);
      });
      document.querySelectorAll('.ad-dot').forEach((d, i) => {
        d.classList.toggle('active', i === n);
      });
      currentSlide = n;
      clearInterval(autoPlay);
      autoPlay = setInterval(() => changeSlide(1), 4000);
    }
  </script>

</asp:Content>