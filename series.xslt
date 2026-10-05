<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>The Reading Nook - Browse by Series</title>
				<style>
					* { box-sizing: border-box; margin: 0; padding: 0; }

					body {
					font-family: 'Georgia', serif;
					background-color: #FDF6EC;
					color: #3C3C3C;
					}

					/* NAVBAR */
					.navbar {
					background-color: #3E2723;
					padding: 16px 40px;
					display: flex;
					align-items: center;
					justify-content: space-between;
					}
					.navbar-brand {
					color: #D4A017;
					font-size: 24px;
					font-weight: bold;
					letter-spacing: 1px;
					text-decoration: none;
					}
					.navbar-links a {
					color: #FDF6EC;
					text-decoration: none;
					margin-left: 24px;
					font-size: 15px;
					}
					.navbar-links a:hover { color: #D4A017; }

					/* HERO */
					.hero {
					background: linear-gradient(135deg, #3E2723 0%, #6D4C41 100%);
					padding: 60px 40px;
					text-align: center;
					}
					.hero h1 {
					color: #D4A017;
					font-size: 42px;
					margin-bottom: 12px;
					letter-spacing: 2px;
					}
					.hero p {
					color: #FDF6EC;
					font-size: 18px;
					font-style: italic;
					}

					/* FILTER BAR */
					.filter-bar {
					background: #fff8f0;
					border-bottom: 2px solid #D4A017;
					padding: 16px 40px;
					display: flex;
					gap: 12px;
					flex-wrap: wrap;
					justify-content: center;
					}
					.filter-btn {
					background: #FDF6EC;
					border: 2px solid #D4A017;
					color: #3E2723;
					padding: 8px 20px;
					border-radius: 25px;
					cursor: pointer;
					font-family: 'Georgia', serif;
					font-size: 14px;
					font-weight: bold;
					transition: all 0.2s;
					}
					.filter-btn:hover, .filter-btn.active {
					background: #D4A017;
					color: white;
					}

					/* SERIES GRID */
					.container {
					max-width: 1200px;
					margin: 0 auto;
					padding: 40px 20px;
					}
					.section-title {
					font-size: 28px;
					color: #3E2723;
					margin-bottom: 24px;
					padding-bottom: 10px;
					border-bottom: 2px solid #D4A017;
					}
					.series-grid {
					display: flex;
					flex-wrap: wrap;
					gap: 24px;
					justify-content: flex-start;
					}
					.series-card {
					background: #fff8f0;
					border: 1px solid #D4A017;
					border-radius: 16px;
					padding: 24px;
					width: 300px;
					box-shadow: 3px 3px 12px rgba(0,0,0,0.08);
					transition: transform 0.2s, box-shadow 0.2s;
					cursor: pointer;
					}
					.series-card:hover {
					transform: translateY(-4px);
					box-shadow: 6px 6px 20px rgba(0,0,0,0.15);
					}
					.series-name {
					font-size: 20px;
					font-weight: bold;
					color: #3E2723;
					margin-bottom: 6px;
					}
					.series-author {
					color: #8B5E3C;
					font-style: italic;
					font-size: 14px;
					margin-bottom: 12px;
					}
					.series-meta {
					display: flex;
					gap: 10px;
					flex-wrap: wrap;
					margin-bottom: 14px;
					}
					.badge {
					padding: 4px 12px;
					border-radius: 20px;
					font-size: 12px;
					font-weight: bold;
					}
					.badge-genre {
					background: #D4A017;
					color: white;
					}
					.badge-books {
					background: #8B5E3C;
					color: white;
					}
					.badge-completed {
					background: #4CAF50;
					color: white;
					}
					.badge-ongoing {
					background: #FF9800;
					color: white;
					}
					.series-desc {
					font-size: 13px;
					color: #555;
					line-height: 1.7;
					margin-bottom: 16px;
					}
					.series-year {
					font-size: 12px;
					color: #8B5E3C;
					margin-bottom: 16px;
					}
					.view-btn {
					display: block;
					background: #3E2723;
					color: #D4A017;
					text-align: center;
					padding: 10px;
					border-radius: 8px;
					text-decoration: none;
					font-weight: bold;
					font-size: 14px;
					transition: background 0.2s;
					}
					.view-btn:hover { background: #D4A017; color: #3E2723; }

					/* FOOTER */
					.footer {
					background: #3E2723;
					color: #FDF6EC;
					text-align: center;
					padding: 30px;
					margin-top: 60px;
					font-size: 14px;
					}
					.footer span { color: #D4A017; }
				</style>
			</head>
			<body>

				<!-- NAVBAR -->
				<div class="navbar">
					<span class="navbar-brand">&#128218; The Reading Nook</span>
					<div class="navbar-links">
						<a href="#">Home</a>
						<a href="#">Books</a>
						<a href="#">Series</a>
						<a href="#">Genres</a>
						<a href="#">Cart</a>
						<a href="#">Login</a>
					</div>
				</div>

				<!-- HERO -->
				<div class="hero">
					<h1>Browse by Series</h1>
					<p>Dive into a world of complete book collections</p>
				</div>

				<!-- FILTER BAR -->
				<div class="filter-bar">
					<button class="filter-btn active">All Series</button>
					<button class="filter-btn">Fantasy</button>
					<button class="filter-btn">Dystopian</button>
					<button class="filter-btn">Romance</button>
					<button class="filter-btn">Sci-Fi</button>
					<button class="filter-btn">Children</button>
				</div>

				<!-- SERIES CARDS -->
				<div class="container">
					<h2 class="section-title">
						All Series
						(<xsl:value-of select="count(series/collection)"/> collections)
					</h2>
					<div class="series-grid">
						<xsl:for-each select="series/collection">
							<div class="series-card">
								<div class="series-name">
									<xsl:value-of select="name"/>
								</div>
								<div class="series-author">
									by <xsl:value-of select="author"/>
								</div>
								<div class="series-meta">
									<span class="badge badge-genre">
										<xsl:value-of select="genre"/>
									</span>
									<span class="badge badge-books">
										<xsl:value-of select="totalBooks"/> Books
									</span>
									<xsl:choose>
										<xsl:when test="status='Completed'">
											<span class="badge badge-completed">Completed</span>
										</xsl:when>
										<xsl:otherwise>
											<span class="badge badge-ongoing">Ongoing</span>
										</xsl:otherwise>
									</xsl:choose>
								</div>
								<div class="series-year">
									Started: <xsl:value-of select="startYear"/>
								</div>
								<div class="series-desc">
									<xsl:value-of select="description"/>
								</div>
								<a class="view-btn" href="#">
									View All <xsl:value-of select="name"/> Books &#8594;
								</a>
							</div>
						</xsl:for-each>
					</div>
				</div>

				<!-- FOOTER -->
				<div class="footer">
					<p>
						&#169; 2025 <span>The Reading Nook</span>. All rights reserved.
					</p>
					<p style="margin-top:8px;">Made with &#10084; for book lovers</p>
				</div>

			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
