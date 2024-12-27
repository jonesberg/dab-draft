schema Artifact:
    build?: str
    executable?: str
    files?: [File]
    path?: str
    type: str

schema File:
    source: str

