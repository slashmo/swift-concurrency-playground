FROM swiftlang/swift:nightly-main-focal as builder

WORKDIR /src

COPY Package.swift .
RUN swift package resolve

COPY . .

RUN swift build -c release

WORKDIR /run

RUN cp $(swift build -c release --package-path /src --show-bin-path)/Playground .

ENTRYPOINT [ "swift", "run" ]

FROM swiftlang/swift:nightly-main-focal-slim

WORKDIR /usr/local/bin

COPY --from=builder /run/Playground .

ENTRYPOINT [ "./Playground" ]
