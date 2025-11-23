--- Configuration module for LuaLaTeX document
-- 
-- This module provides a centralized configuration system for LaTeX document settings,
-- asset management, references, and typesetting options. The configuration can be
-- overridden by a user-specific configuration file in the repository root.
--
-- @module configuration
-- @return Configuration table

local configuration = {}

-- Build system configuration
-- Controls output directories and build artifacts
configuration.build = {
    -- Directory for intermediate build files (aux, log, etc.)
    dir = 'build/',
    -- Directory for final output files (PDFs)
    out = 'pdf/'
}

-- Asset management configuration
-- Controls how external assets (images, tables, etc.) are handled
configuration.assets = {
    -- Root directory for all assets
    root = 'assets/',
    -- Enable custom LaTeX macros for quick insertion of figures/tables/etc.
    shortcuts = true,
    -- Enable externalization of assets (caching processed versions)
    -- 	For externalization 'memoize' package is used. Note that this
	-- 	requires quite modern LaTeX version, as well as some external
	--- dependicies, like Perl and PDF::API2 library
    externalize = true,
    -- Asset type configurations:
    -- 'keep' - memoize puts files in the same directory as source
    -- 'build' - memoize puts files into build directory  
    -- 'none' - disable memoization for this asset type
    dirs = {
        images = { path = 'images/', extern = 'keep' },      -- Raster/vector images
        tables = { path = 'tables/', extern = 'build' },     -- Data tables, CSV files
        diagrams = { path = 'diagrams/', extern = 'keep' },  -- Diagram source files
        listings = { path = 'listings/', extern = 'keep' }   -- Code listings
    }
}

-- References and bibliography configuration
-- Manages citations, indexes, and knowledge graphs
configuration.references = {
	enable = true,
	--- Tooling for references
	hyperref = {
	  shortref = {
		{csname = 'picref', reftext = 'рис.'},
		{csname = 'tabref', reftext = 'табл.'},
		{csname = 'lstref', reftext = 'листинг'},
		{csname = 'digref', reftext = 'диаг.'},
		{csname = 'secref', reftext = 'разд.'}
	  },
	  hypersetup = {
		breaklinks=true,
		hyperindex=true,
		colorlinks=true,
		hidelinks=false,
        hypertexnames='false', --- fix, cause right now false boolean filds are ignored
		unicode=true,
		pdfauthor={'Unknown Author'},
		pdfsubject={'Document Subject'},
		pdfkeywords={'keyword1, keyword2'},
		pdftitle={'Document Title'},
		bookmarksopen=false,
		linktocpage=true,
		plainpages=false,
		pdfpagelabels=true,
		-- Link colors
		urlcolor='blue',
		linkcolor='red',
		filecolor='red',
		citecolor='blue'
	  }
	},
    -- Bibliography sources configuration
    bibtex = {
        -- Base path for bibliography files
        path = 'assets/bibliography',
		style = 'numeric',
        -- List of bibliography databases with display names
        bibliographies = {
            {
                name = 'main',  -- Main literature bibliography
                title = 'Список литературы',  -- Main literature bibliography
                files = 'main.bib',
            },
            -- {
            --     name = 'git',  -- Software/online sources
            --     title = 'Репозитории, трекеры, обсуждения',  -- Software/online sources
            --     files = { 'repos.bib', 'issues.bib' },
            -- }
        }
    },
    -- Index generation configuration (imakeidx package)
    indexes = {
        -- Enable index generation
        enable = true,
		-- imakeidx options
		build = {'makeindex'},
        -- Configure individual indexes
        list = {
			-- Symbol index
            { 
			  name = 'notation',
			  title = 'Список обозначений',
			  intoc = true,
			  --columns = 2,
			  --columnsep = '15pt',
			  --columnseprule = true,
			},  
			-- Main subject index
            { 
			  name = nil,
			  title = 'Предметный указатель',
			  intoc = true,
			}                  
        }
    },
    -- Knowledge configuration (knowledge package)
    -- knowledge = {
        -- Enable knowledge graph functionality
        -- enable = true,
        -- Configuration file for knowledge package
        -- config = '.knowledgerc.tex'
    -- }
}

-- Float environment configuration
-- Controls figures, tables, listings, and other floating elements
configuration.floats = {
    -- Enable plugin for handling macroses
    enable = true,
    -- Graphics scaling and sizing options
    images = {
		-- Enable quiver package for commutative diagrams
		quiver = 'enabled', -- alternative is 'draft' or 'disabled'
		-- TODO: Enable drawio package for draw.io diagram integration  
		-- drawio = 'enabled', -- alternative is 'draft' or 'disabled'
		
		-- Default caption position 
		caption = 'below',
		-- Default width ratio to \linewidth for regular figures (0.0-1.0)
        figurewidth = 0.9,
        -- Default width ratio for wrapfigure environments (0.0-1.0)
        wrapfigurewidth = 0.4,
		--- Whether or not create separate list of figures
		makeidx = true,
    },
	tables = {
	  enables = true,
	  caption = 'above',
	  makeidx = true,
	},
    -- Code listing configuration
    listing = {
        -- Enable listing environment support
        enable = true,
		caption = 'above',
        -- Enable syntax highlighting via pygmentize
        pygmentize = true,
		makeidx = true,
    },
    -- Caption and labeling configuration
    captions = {
        -- Language for automatic captions (e.g., "Figure", "Table")
        lang = 'ru',
    }
}

-- Typesetting and text macros configuration
-- Controls custom text formatting, shortcuts, and theorem environments
configuration.typesetting = {
    -- Enable custom typesetting macros
    enable = true,
	
    -- Text shortcut configuration
	shortcuts = true, 

	-- Formatting features
	formatting = {
	  todo = true,
	  ulem = true,
	},
    -- Theorem and proof environment configuration
    theorems = {
        -- Enable theorem-like environments (theorem, lemma, proof, etc.)
        enable = true,
		--- Theorem naming style
		--- plain: 
		---		theorem - numbered theorem
		---		theorem* - unnumbered theorem
		--- framed: 
		---		Theorem - numbered theorem, framed
		---		Theorem* - unnumbered theorem, framed
		---		theorem - numbered theorem, not framed
		---		theorem* - unnumbered theorem, not framed
		thmstyle = 'framed',
		enviroments = {
		  {envname = 'theorem', name = 'Теорема'},
		  {envname = 'lemma', name = 'Лемма'},
		  {envname = 'proposition', name = 'Предложение'},
		  {envname = 'definition', name = 'Определение'},
          {envname = 'remark', name = 'Замечание'},

		}
    }
}

-- Mathematical typesetting configuration
-- Controls math macros, symbols, and specialized notation
configuration.mathematics = {
    -- Enable mathematical typesetting macros
    enable = true,
	mathcommand = 'error',
    -- Mathematical domain-specific plugin configuration
    plugins = {
        -- Algebra plugin: groups, rings, fields, linear algebra
        algebra = {
            enable = true,          -- Enable algebra macros
            --knowledgify = true,     -- Generate knowledge graph entries
            --indexify = false,       -- Add to index automatically
        },
        -- Calculus plugin: limits, derivatives, integrals
        calculus = {
            enable = true,
            --knowledgify = true,
            --indexify = false
        },
        -- Combinatorics plugin: combinations, permutations, graphs
        combinatorics = {
            enable = true,
            --knowledgify = true,
            --indexify = false
        },
        -- Probability plugin: distributions, expectations, random variables
        probability = {
            enable = true,
            --knowledgify = true,
            --indexify = false,
        },
        -- Foundations plugin: set theory, logic, category theory
        foundations = {
            enable = true,
            --knowledgify = true,
            --indexify = false
        },
        -- Complexity plugin: Big-O notation, complexity classes
        complexity = {
            enable = false  -- Disabled by default
        }
    }
}

return configuration
