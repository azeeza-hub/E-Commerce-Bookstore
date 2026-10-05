<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>The Reading Nook - Book Catalog</title>
				<style>
					body {
					font-family: 'Georgia', serif;
					background-color: #FDF6EC;
					color: #3C3C3C;
					margin: 0;
					padding: 20px;
					}
					h1 {
					text-align: center;
					color: #3E2723;
					font-size: 36px;
					margin-bottom: 10px;
					}
					.subtitle {
					text-align: center;
					color: #8B5E3C;
					margin-bottom: 30px;
					font-style: italic;
					}
					.book-grid {
					display: flex;
					flex-wrap: wrap;
					gap: 20px;
					justify-content: center;
					}
					.book-card {
					background-color: #fff8f0;
					border: 1px solid #d4a017;
					border-radius: 10px;
					padding: 20px;
					width: 250px;
					box-shadow: 3px 3px 10px rgba(0,0,0,0.1);
					}
					.book-card h2 {
					color: #3E2723;
					font-size: 16px;
					margin-bottom: 5px;
					}
					.author {
					color: #8B5E3C;
					font-style: italic;
					font-size: 14px;
					}
					.genre {
					display: inline-block;
					background-color: #D4A017;
					color: white;
					padding: 2px 10px;
					border-radius: 20px;
					font-size: 12px;
					margin: 8px 0;
					}
					.price {
					color: #3E2723;
					font-weight: bold;
					font-size: 18px;
					}
					.stock {
					color: #8B5E3C;
					font-size: 13px;
					}
					.description {
					font-size: 13px;
					color: #555;
					margin-top: 8px;
					line-height: 1.5;
					}
				</style>
			</head>
			<body>
				<h1>📚 The Reading Nook</h1>
				<p class="subtitle">Your cozy corner for every story</p>

				<div class="book-grid">
					<xsl:for-each select="books/book">
						<div class="book-card">
							<h2>
								<xsl:value-of select="title"/>
							</h2>
							<p class="author">
								by <xsl:value-of select="author"/>
							</p>
							<span class="genre">
								<xsl:value-of select="genre"/>
							</span>
							<p class="price">
								RM <xsl:value-of select="price"/>
							</p>
							<p class="stock">
								In Stock: <xsl:value-of select="stock"/> copies
							</p>
							<p class="description">
								<xsl:value-of select="description"/>
							</p>
						</div>
					</xsl:for-each>
				</div>

			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>