\documentclass[
author={Riley Evans},
supervisor={Dr. Meng Wang},
degree={MEng},
title={\vbox{Circuit: A Domain Specific Language for Dataflow Programming}},
subtitle={},
type={research},
year={2021}
]{dissertation}


\usepackage{todonotes}
\setlength{\marginparwidth}{2cm}
\usepackage{caption}
\usepackage{subcaption}
\usepackage{amsmath}
\usepackage{tikz-cd}
\usepackage{latexsym}
\usepackage{acronym}


\usepackage{subfiles} % load last

% lhs2tex setup
%include format.fmt
%options ghci -pgmL lhs2tex -optL--pre

\begin{document}

%to ignore a code block in latex...


\maketitle

% =============================================================================

\frontmatter
\makedecl{}
\tableofcontents
\listoffigures

% -----------------------------------------------------------------------------

% \chapter*{Supporting Technologies}

% % -----------------------------------------------------------------------------

\chapter*{Notation and Acronyms}

\begin{acronym}
  \acro{DSL}{Domain Specific Language}
  \acro{EDSL}{Embedded DSL}
  \acro{FIFO}{First-In First-Out}
  \acro{KPN}{Kahn Process Network}
  \acro{GPL}{General Purpose Language}
  \acro{DPN}{Data Process Network}
  \acro{AST}{Abstract Syntax Tree}
\end{acronym}

% maybe?

% -----------------------------------------------------------------------------

\chapter*{Acknowledgements}

\todo[inline]{Change this to something meaningful}
\noindent
It is common practice (although totally optional) to acknowledge any
third-party advice, contribution or influence you have found useful
during your work.  Examples include support from friends or family, 
the input of your Supervisor and/or Advisor, external organisations 
or persons who  have supplied resources of some kind (e.g., funding, 
advice or time), and so on.

% =============================================================================

\mainmatter{}

%if style == poly
\subfileinclude{introduction}
%endif

% -----------------------------------------------------------------------------

%if style == poly
\subfileinclude{background}
%endif

% -----------------------------------------------------------------------------

\chapter{Project Execution}\label{chap:execution}



% -----------------------------------------------------------------------------

\chapter{Critical Evaluation}\label{chap:evaluation}

% -----------------------------------------------------------------------------

\chapter{Conclusion}\label{chap:conclusion}

% =============================================================================

\backmatter{}

\listoftodos

\bibliography{dissertation}


% =============================================================================

\end{document}

% ----- Configure Emacs -----
%
% Local Variables: ***
% mode: latex ***
% mmm-classes: literate-haskell-latex ***
% End: ***
