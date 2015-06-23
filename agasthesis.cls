%%
%% agasthesis.cls
%%
%% $Id: agasthesis.cls 354 2009-05-12 13:43:09Z droege $
%%
\NeedsTeXFormat{LaTeX2e}              % Latex format
\ProvidesClass{agasthesis}            % class name
\def\BaseClass{book}                  % define base class
% pass options to base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\BaseClass}} 
\ProcessOptions                       % process options
\LoadClass[twoside,12pt,a4paper]{\BaseClass}  % load base class with arguments
\RequirePackage{a4}                   % a4 page layout (former a4wide)
\RequirePackage{german}               % german hyphenation etc.
\RequirePackage{amsmath}              % standard math notation (vectors/sets/...)
\RequirePackage{amssymb}              % AMS math symbols
\RequirePackage{math}                 % standard math notation (vectors/sets/...)
\RequirePackage{graphicx}             % eps graphics support
\usepackage[small,bf]{caption}        % for small captions in figures, tables etc.
\RequirePackage{subfig}            % for multiple images in one figure
%\RequirePackage{palatino}            % use palatino font
%\RequirePackage{times}               % use times font
\RequirePackage{listings}             % for source code and algorithms
\usepackage{psfrag}                   % for eps figure manipulation

\clubpenalty = 10000                  % against clubs
\widowpenalty = 10000                 % against
\displaywidowpenalty = 10000          % widows

% clear double page on new chapter
\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{%
  \clearpage
  {\pagestyle{empty}\origdoublepage}%
}

\let\oldChapter=\chapter
\def\chapter{\clearemptydoublepage\oldChapter}

%% Test ob PDF-Ausgabemodus aktiv ist, dann PDF, PNG und JPG zulassen
\newif\ifmakepdf
\makepdffalse
\ifx\pdfoutput\undefined
  % (z.B., wenn gar nicht pdfTeX laeuft)
\else
  \ifx\pdfoutput\relax
    % (z.B. nach vorigem \@ifundefined{pdfoutput})
  \else
    \ifcase\pdfoutput
      % (pdfTeX: DVI-Modus)
    \else
      % Jetzt erst ist der PDF-Modus-Test positiv
      \makepdftrue
    \fi
  \fi
\fi

%% pdflatex-specific settings
\ifmakepdf
  \relax
\else
  \usepackage{microtype}
\fi
%%%%%
\endinput
