use 5.006001;
use ExtUtils::MakeMaker;

my $have_test_requires = ExtUtils::MakeMaker->VERSION ge '6.64';
my %test_req = (
    'Test::More' => '0.98',
);                                                                                                                                                                                             
WriteMakefile(
    NAME             => "Data::Dumper",
    VERSION_FROM     => 'Dumper.pm',
    'dist'           => {
        COMPRESS     => 'gzip -9f',
        SUFFIX       => 'gz',
        DIST_DEFAULT => 'all tardist',
    },
    MAN3PODS         => {},
    DEFINE           => '-DUSE_PPPORT_H',

    # 'perl' is reserved for things that shipped with the perl version;
    # on perls after 5.011000, 'site' has precedence over 'perl', but before
    # that 'perl' had precedence so we need to keep installing to there.
    "$]" <= 5.011000 ? ( INSTALLDIRS => 'perl' ) : (),

    PREREQ_PM => {
        $have_test_requires ? () : %test_req,
    },
    $have_test_requires ? (TEST_REQUIRES => \%test_req) : (),
    META_MERGE => {
        dynamic_config => 0,
        resources => {
            repository  => 'git://perl5.git.perl.org/perl.git perl-git',
            bugtracker  => 'http://rt.perl.org/perlbug/',
            MailingList => 'http://lists.cpan.org/showlist.cgi?name=perl5-porters'
        },
    }
);
