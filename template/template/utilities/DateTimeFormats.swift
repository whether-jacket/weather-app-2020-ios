import Foundation

enum DayOfWeek: String {
    case Sixth = "d"
    case Mon = "EEE"
    case Monday = "EEEE"
}

enum DayYear: String {
    case D_YYYY = "d, YYYY"
}

enum Month: String {
    case Jun = "MMM"
    case June = "MMMM"
    case SIX = "" // TODO
}

enum MonthDay: String {
    case JUL_1 = "MMM d"
    case JUL_01 = "MMM dd"
    case JULY_1 = "MMMM d"
    case JULY_01 = "MMMM dd"
    case MON_JUL_17 = "EEE, MMM d"
}

enum YearMonthDay: String {
    case YYYYMDD = "yyyyMdd"
    case YYYYMMDD = "yyyyMMdd"
    case YYYY_M_DD_DASH = "yyyy-M-dd"
    case YYYY_MM_DD_DASH = "yyyy-MM-dd"
    case YYYY_M_DD_SLASH = "yyyy/M/dd"
    case YYYY_MM_DD_SLASH = "yyyy/MM/dd"
    case YYYY_M_DD_SPACE = "yyyy M dd"
    case YYYY_MM_DD_SPACE = "yyyy MM dd"
    case MMM_D_YYYY_SPACE = "MMM d, yyyy"
    case MM_DD_YYYY_SLASH = "MM/dd/yyyy"
    case M_D_YYYY_SLASH = "M/d/yyyy"
    case DAY_MMM_D_YY = "EEE, MMM d, ''yy"
    case DAY_MMM_D_YYYY = "EEEE, MMM d, yyyy"
}

enum YearMonthDayTime: String {
    case YYYY_MM_DD_TIME_Z = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case USA_MILITARY_WITH_ZONE = "M/dd/yyyy HH:mm z"
    case USA_WITH_ZONE = "M/dd/yyyy h:mm a z"
    case USA = "M/dd/yyyy h:mm a"
}

enum Time: String {
    // kk = Hours in 1-24 format
    // hh = hours in 1-12 format
    // KK = hours in 0-11 format
    // HH = hours in 0-23 format
    case H = "h"
    case HH = "hh"
    case H_24 = "H"
    case HH_24 = "HH"
    case M = "m"
    case MM = "mm"
    case S = "s"
    case SS = "ss"
    case H_MM_24 = "H:mm"
    case HH_MM_24 = "HH:mm"
    case H_MM = "h:mm"
    case HH_MM = "hh:mm"
    case H_MM_AM = "h:mm a"
    case HH_MM_AM = "hh:mm a"
    case HH_MM_SS_AM = "hh:mm:ss a"
    case HH_MM_SS_24 = "HH:mm:ss"
}
