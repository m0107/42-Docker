<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'WordPress' );

/** MySQL database username */
define( 'DB_USER', 'WordPressUser' );

/** MySQL database password */
define( 'DB_PASSWORD', 'admin1234' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '.tMhs+&K@]d).Vj)1Au=UZ[~u+8:6yG{:R](I8O:/hs:SV3Ok?U,IMBOdGF`=Tdd' );
define( 'SECURE_AUTH_KEY',  'H l0xcf-l=jI)p}5{Prs1&OxV*#t:NM[h6,q@d0!6qu(g%#Ypa]nMYmIIis8[<Bd' );
define( 'LOGGED_IN_KEY',    'tD8HRrO,{RAB6Bi#31_s4P*zoI@kb:2!5S)Kiu R[:.gVXKHflF5z<QHwdM}aVu_' );
define( 'NONCE_KEY',        'I/K1R!n1%6q+,NO&#QU7yA,!:+]iX@>bF4Bh-?[NCE}|]f^Noz!9=4kE/-^9Un=E' );
define( 'AUTH_SALT',        'Aakjlj~;^-QNw0E=a1>B;<!oT:peaEMEr>SFJ=}[#z99+C7GOA+H*@tYs[4=c+hB' );
define( 'SECURE_AUTH_SALT', '>l,(IZ&zu;Kt{i#g!)cQYxU*aByy2/?pr$gnkH]!<}t_ZH!R&e%Trq3bzKO/t3KO' );
define( 'LOGGED_IN_SALT',   '~m)=O.d gLUJ4dziMJVG(5aqUS(as b.LZ[`Y{9igFER{W8ea4;pTnS>U[lY2AvJ' );
define( 'NONCE_SALT',       '9-q2|Z>wGk]]0Zw1F/qmV!=TuV7)R{=m2~W$3-M/wgH7/&8M*}OctdLi}:cVhFM)' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
