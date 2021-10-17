// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
// Custom template

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Series {
    ///  at %@
    internal static func at(_ p1: String) -> String {
      return L10n.tr("Localizable", "series.at", p1)
    }
    /// We didn't find any series
    internal static var emptyMessage: String {
      L10n.tr("Localizable", "series.empty_message")
    }
    /// %d episodes
    internal static func episodes(_ p1: Int) -> String {
      return L10n.tr("Localizable", "series.episodes", p1)
    }
    /// Could not load data. Try again
    internal static var errorMessage: String {
      L10n.tr("Localizable", "series.error_message")
    }
    /// Genres: 
    internal static var genres: String {
      L10n.tr("Localizable", "series.genres")
    }
    /// Schedule: 
    internal static var schedule: String {
      L10n.tr("Localizable", "series.schedule")
    }
    /// Search
    internal static var search: String {
      L10n.tr("Localizable", "series.search")
    }
    /// Season %d
    internal static func season(_ p1: Int) -> String {
      return L10n.tr("Localizable", "series.season", p1)
    }
    /// Series
    internal static var title: String {
      L10n.tr("Localizable", "series.title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = Bundle.main.localizedString(forKey: key, value: "", table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
