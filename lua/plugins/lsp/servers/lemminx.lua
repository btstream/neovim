local settings = {
    xml = {
        server = {
            workDir = "~/.cache/lemminx",
        },
        format = {
            closingBracketNewLine = false, -- Put closing bracket on a new line for tags with multiple attributes
            emptyElements = "ignore", -- Handling of empty elements: ignore/collapse/expand
            enabled = true, -- Enable/disable XML formatting
            enforceQuoteStyle = "ignore", -- Enforce preferred quote style or ignore
            grammarAwareFormatting = true, -- Use Schema/DTD grammar information (Not supported by legacy formatter)
            joinCDATALines = false, -- Join lines in CDATA content
            joinCommentLines = true, -- Join lines in comments
            joinContentLines = false, -- Normalize whitespace in element content
            legacy = false, -- Use legacy XML formatter
            maxLineWidth = 0, -- Max line width for formatting (Not supported by legacy formatter)
            preserveAttributeLineBreaks = true, -- Preserve line breaks before and after attributes
            preserveEmptyContent = true, -- Preserve empty whitespace content (Legacy formatter only)
            preserveSpace = { -- Element names to preserve space
                "literallayout",
                "pre",
                "programlisting",
                "screen",
                "synopsis",
                "xd:pre",
                "xsl:comment",
                "xsl:processing-instruction",
                "xsl:text",
            },
            preservedNewlines = 2, -- Number of blank lines to leave between tags
            spaceBeforeEmptyCloseTag = true, -- Insert space before end of self-closing tags
            splitAttributes = "preserve", -- Split node attributes onto multiple lines: preserve/splitNewLine/alignWithFirstAttr
            splitAttributesIndentSize = 2, -- Indentation level for attributes when split
            xsiSchemaLocationSplit = "onPair", -- How to format xsi:schemaLocation content
        },
    },
}
return {
    settings = settings,
    init_options = {
        settings = settings,
    },
}
