<%@ Page Title="Find Your Book" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookQuiz.aspx.cs" Inherits="PageTurnerBookstore.BookQuiz" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .quiz-wrapper { max-width: 800px; margin: 0 auto; padding: 60px; }
  .quiz-hero {
    background: linear-gradient(135deg, #3E2723, #6D4C41);
    border-radius: 24px;
    padding: 50px;
    text-align: center;
    margin-bottom: 40px;
    border: 1px solid rgba(212,160,23,0.3);
    position: relative;
    overflow: hidden;
  }
  .quiz-hero::before { content: '📚'; position: absolute; font-size: 200px; opacity: 0.05; right: -20px; top: -20px; }
  .quiz-hero h1 { font-family: 'Playfair Display', serif; font-size: 42px; color: #D4A017; margin-bottom: 12px; }
  .quiz-hero p { color: rgba(253,246,236,0.7); font-size: 18px; font-family: 'Cormorant Garamond', serif; font-style: italic; }
  .quiz-xml-badge { display: inline-block; background: rgba(212,160,23,0.2); border: 1px solid rgba(212,160,23,0.4); color: #D4A017; padding: 4px 14px; border-radius: 20px; font-size: 11px; font-weight: 700; letter-spacing: 1px; margin-bottom: 16px; }
  .progress-wrap { margin-bottom: 32px; }
  .progress-label { display: flex; justify-content: space-between; font-size: 13px; color: #8B5E3C; margin-bottom: 8px; font-weight: 700; }
  .progress-bar { height: 8px; background: #f0e8de; border-radius: 10px; overflow: hidden; }
  .progress-fill { height: 100%; background: linear-gradient(90deg, #3E2723, #D4A017); border-radius: 10px; transition: width 0.5s ease; }
  .question-card { background: white; border-radius: 20px; padding: 40px; box-shadow: 0 8px 30px rgba(62,39,35,0.1); border: 1px solid rgba(212,160,23,0.15); margin-bottom: 24px; }
  .question-num { font-size: 12px; font-weight: 700; color: #D4A017; text-transform: uppercase; letter-spacing: 2px; margin-bottom: 12px; }
  .question-text { font-family: 'Playfair Display', serif; font-size: 26px; color: #3E2723; margin-bottom: 28px; line-height: 1.3; }
  .options-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
  .option-btn { background: #FFFDF9; border: 2px solid #e8d5c0; border-radius: 14px; padding: 18px 20px; font-size: 15px; color: #3E2723; cursor: pointer; transition: all 0.2s; font-family: 'Lato', sans-serif; text-align: left; font-weight: 600; }
  .option-btn:hover { border-color: #D4A017; background: rgba(212,160,23,0.08); transform: translateY(-2px); }
  .option-btn.selected { border-color: #3E2723; background: #3E2723; color: #D4A017; }
  .results-section { display: none; }
  .results-hero { text-align: center; padding: 40px 0; }
  .results-hero h2 { font-family: 'Playfair Display', serif; font-size: 36px; color: #3E2723; margin-bottom: 8px; }
  .results-hero p { font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 20px; color: #8B5E3C; margin-bottom: 40px; }
  .genre-result { display: inline-block; background: #3E2723; color: #D4A017; padding: 10px 28px; border-radius: 30px; font-size: 18px; font-weight: 700; margin-bottom: 40px; }
  .recommended-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 40px; }
  .rec-card { background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 20px rgba(62,39,35,0.07); border: 1px solid rgba(212,160,23,0.12); transition: transform 0.3s; text-decoration: none; display: block; }
  .rec-card:hover { transform: translateY(-6px); }
  .rec-cover { height: 200px; overflow: hidden; position: relative; }
  .rec-cover img { width: 100%; height: 100%; object-fit: cover; }
  .rec-body { padding: 16px; }
  .rec-series { font-size: 10px; font-weight: 700; color: #D4A017; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 4px; }
  .rec-title { font-family: 'Playfair Display', serif; font-size: 14px; font-weight: 700; color: #3E2723; margin-bottom: 4px; line-height: 1.3; }
  .rec-author { font-size: 12px; color: #6B4C3B; font-style: italic; margin-bottom: 10px; }
  .rec-price { font-size: 18px; font-weight: 700; color: #3E2723; }
  .btn-retake { display: inline-block; background: transparent; color: #3E2723; border: 2px solid #e8d5c0; padding: 14px 36px; border-radius: 10px; font-size: 15px; font-weight: 700; cursor: pointer; font-family: 'Lato', sans-serif; transition: all 0.2s; margin-right: 12px; }
  .btn-retake:hover { border-color: #D4A017; color: #D4A017; }
  .btn-browse-results { display: inline-block; background: #3E2723; color: #D4A017; padding: 14px 36px; border-radius: 10px; font-size: 15px; font-weight: 700; text-decoration: none; transition: all 0.2s; }
  .btn-browse-results:hover { background: #D4A017; color: #3E2723; }
  .genre-colors-Fantasy { background: linear-gradient(135deg, #1a1a3e, #2d2d6b); }
  .genre-colors-Dystopian { background: linear-gradient(135deg, #2d0a0a, #6b1a1a); }
  .genre-colors-Romance { background: linear-gradient(135deg, #2d0a1a, #6b1a3a); }
  .genre-colors-Sci-Fi { background: linear-gradient(135deg, #0a2d2d, #1a6b6b); }
  .genre-colors-Children { background: linear-gradient(135deg, #1a2d0a, #3a6b1a); }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="quiz-wrapper">

    <div class="quiz-hero">
      <h1>🎯 Find Your Perfect Book</h1>
      <p>Answer 5 quick questions and we'll recommend the perfect book for you!</p>
    </div>

    <div id="quizSection">
      <div class="progress-wrap">
        <div class="progress-label">
          <span id="progressText">Question 1 of 5</span>
          <span id="progressPct">20%</span>
        </div>
        <div class="progress-bar">
          <div class="progress-fill" id="progressFill" style="width:20%"></div>
        </div>
      </div>
      <div class="question-card">
        <div class="question-num" id="questionNum">Question 1</div>
        <div class="question-text" id="questionText">Loading...</div>
        <div class="options-grid" id="optionsGrid"></div>
      </div>
    </div>

    <div class="results-section" id="resultsSection">
      <div class="results-hero">
        <h2>🎉 Your Perfect Match!</h2>
        <p>Based on your answers, we recommend...</p>
        <div class="genre-result" id="genreResult"></div>
      </div>
      <div class="recommended-grid">
        <asp:Repeater ID="rptRecommended" runat="server">
          <ItemTemplate>
            <a href='/BookDetail.aspx?id=<%# Eval("BookID") %>' class="rec-card">
              <div class="rec-cover genre-colors-<%# Eval("Genre") %>">
                <%# !string.IsNullOrEmpty(Eval("CoverImage").ToString())
                  ? "<img src='/Images/" + Eval("CoverImage") + "' onerror=\"this.src='https://covers.openlibrary.org/b/isbn/" + Eval("ISBN") + "-M.jpg'\"/>"
                  : "<img src='https://covers.openlibrary.org/b/isbn/" + Eval("ISBN") + "-M.jpg'/>" %>
              </div>
              <div class="rec-body">
                <div class="rec-series"><%# Eval("Series") %></div>
                <div class="rec-title"><%# Eval("Title") %></div>
                <div class="rec-author">by <%# Eval("Author") %></div>
                <div class="rec-price">RM <%# Eval("Price", "{0:F2}") %></div>
              </div>
            </a>
          </ItemTemplate>
        </asp:Repeater>
      </div>
      <div style="text-align:center;">
        <button class="btn-retake" onclick="retakeQuiz()">🔄 Retake Quiz</button>
        <a href="/BookList.aspx" class="btn-browse-results">Browse All Books →</a>
      </div>
    </div>

    <asp:HiddenField ID="hdnGenre" runat="server"/>
<asp:Button ID="btnSubmit" runat="server" Text="Submit"
  OnClick="btnSubmit_Click" 
  UseSubmitBehavior="true"
  Style="display:none; visibility:hidden;"/>

  </div>

  <script>
      var questions = <%= QuizQuestionsJson %>;
      var currentQ = 0;
      var scores = {};

      function loadQuestion(index) {
          var q = questions[index];
          document.getElementById('questionNum').innerText = 'Question ' + (index + 1);
          document.getElementById('questionText').innerText = q.text;
          document.getElementById('progressText').innerText = 'Question ' + (index + 1) + ' of 5';
          document.getElementById('progressPct').innerText = Math.round(((index + 1) / 5) * 100) + '%';
          document.getElementById('progressFill').style.width = Math.round(((index + 1) / 5) * 100) + '%';

          var grid = document.getElementById('optionsGrid');
          grid.innerHTML = '';

          for (var i = 0; i < q.options.length; i++) {
              (function (opt) {
                  var btn = document.createElement('button');
                  btn.type = 'button';
                  btn.className = 'option-btn';
                  btn.innerText = opt.text;
                  btn.onclick = function () { selectOption(opt.value, btn); };
                  grid.appendChild(btn);
              })(q.options[i]);
          }
      }

      function selectOption(value, btn) {
          var btns = document.querySelectorAll('.option-btn');
          for (var i = 0; i < btns.length; i++) {
              btns[i].onclick = null;
              btns[i].classList.remove('selected');
          }
          btn.classList.add('selected');

          if (!scores[value]) scores[value] = 0;
          scores[value]++;

          setTimeout(function () {
              currentQ++;
              if (currentQ < questions.length) {
                  loadQuestion(currentQ);
              } else {
                  showResults();
              }
          }, 600);
      }

      function showResults() {
          var topGenre = '';
          var topScore = 0;
          for (var key in scores) {
              if (scores[key] > topScore) {
                  topScore = scores[key];
                  topGenre = key;
              }
          }
          document.getElementById('<%= hdnGenre.ClientID %>').value = topGenre;
         document.getElementById('genreResult').innerText = topGenre;

         // Force form submit
         var btn = document.getElementById('<%= btnSubmit.ClientID %>');
         btn.click();
     }

      function retakeQuiz() {
          scores = {};
          currentQ = 0;
          document.getElementById('quizSection').style.display = 'block';
          document.getElementById('resultsSection').style.display = 'none';
          loadQuestion(0);
      }

      window.onload = function () {
          loadQuestion(0);
      };
  </script>
</asp:Content>