#!/usr/bin/env wolframscript

If[PacletFind["M2MD"]==={},
  ResourceFunction["GitHubInstall"]["kubaPod", "M2MD"]
]

Needs["M2MD`"]

$baseDir = DirectoryName@$InputFileName;
$nbDir = FileNameJoin@{$baseDir, "notebooks"};
$mdDir = FileNameJoin@{$baseDir, "markdown"};

mdFile[nb_String]:=mdFile[nb]=ResourceFunction["EnsureFilePath"]@FileNameJoin@{
  $mdDir,
  FileBaseName[nb]<>".md"
}

UsingFrontEnd@FileSystemScan[
  Function[
    nb,
    MDExport[
      mdFile[nb],
      NotebookOpen[nb],
      "ImagesFetchURL" -> URL["img"],
      "MDElementTemplates" -> <|
        "LaTeXBlock" -> "![`1`](http://latex.codecogs.com/svg.latex?`1`)",
        "LaTeXInline" -> "![`1`](http://latex.codecogs.com/svg.latex?`1`)"
      |>
    ];
    Print[nb, " -> ", mdFile[nb]]
  ],
  $nbDir,
  FileNameForms->"*.nb"
]

Exit[]
