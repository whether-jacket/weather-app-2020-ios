import Foundation

struct Spacings {
    static let quarter = 2
    static let half = 4
    static let spacing = 8
    static let double = spacing * 2     // 16
    static let triple = spacing * 3     // 24
    static let quadruple = spacing * 4  // 32
    static let quintuple = spacing * 5  // 40
    static let sextuple = spacing * 6   // 48
    static let septuple = spacing * 7   // 56
    static let octuple = spacing * 8    // 64
    static let nonuple = spacing * 9    // 72
}

struct HorizontalSpacings {
    static let xxs = Spacings.quarter
    static let xs = Spacings.half
    static let s = Spacings.spacing
    static let m = Spacings.double
    static let l = Spacings.triple
    static let xl = Spacings.quadruple
    static let xl2 = Spacings.quintuple
    static let xl3 = Spacings.sextuple
    static let xl4 = Spacings.septuple
}

struct VerticalSpacings {
    static let xxs = Spacings.quarter
    static let xs = Spacings.half
    static let s = Spacings.spacing
    static let m = Spacings.double
    static let l = Spacings.triple
    static let xl = Spacings.quadruple
    static let xl2 = Spacings.quintuple
    static let xl3 = Spacings.sextuple
    static let xl4 = Spacings.septuple
}

struct Padding {
    static let xxs = Spacings.quarter
    static let xs = Spacings.half
    static let s = Spacings.spacing
    static let m = Spacings.double
    static let l = Spacings.triple
    static let xl = Spacings.quadruple
    static let xl2 = Spacings.quintuple
    static let xl3 = Spacings.sextuple
    static let xl4 = Spacings.septuple
}

struct CornerRadius {
    static let xxs = 2
    static let xs = 4
    static let s = 6
    static let m = 8
    static let l = 10
}

struct TextSizes {
    private static let xxs = 12
    private static let xs = 14
    private static let s = 16
    private static let m = 18
    private static let l = 22
    private static let xl = 26
    private static let xxl = 32
    private static let xl3 = 42
    private static let xl4 = 64

    static let body = xs
    static let subhead = s
    static let title = l // 20 on Android
    static let large = xl // 22 on Android
}
