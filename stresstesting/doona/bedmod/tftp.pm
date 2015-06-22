package bedmod::tftp;
use Socket;

# lame tftp plugin :)

# create a new instance of this object
sub new {
    my $this = {};
    bless $this;
    return $this;
}

# initialise some parameters
sub init{
    my $this = shift;
    %special_cfg=@_;

    # Set protocol tcp/udp
    $this->{proto} = "udp";

    if ($special_cfg{'p'} eq "") { $this->{port}='69'; }
    else { $this->{port} = $special_cfg{'p'}; }
    $this->{sport} = 0;
    $this->{vrfy} = "";
}

# how to quit ?
sub getQuit {
    return("");
}

# what to test without doing a login before
sub getLoginarray {
    my $this = shift;
    @Loginarray = ("");
    return (@Loginarray);
}

# which commands does this protocol know ?
sub getCommandarray {
    my $this = shift;

    # the XAXAX will be replaced with the buffer overflow / format string
    # place every command in this array you want to test
    @cmdArray = (
        "XAXAX", # B0F
        "\x00\x01XAXAX\x00netascii\x00", #RRQ
        "\x00\x01XAXAX\x00octet\x000", #RRQ
        "\x00\x01XAXAX\x00mail\x00", #RRQ
        "\x00\x01"."fuzz\x00XAXAX\x00", #RRQ
        "\x00\x02\x41\x00XAXAX\x00", #WRQ
        "\x00\x03\x41\x00XAXAX\x00", #DATA?
        "\x0c\x0dXAXAX\x00",
      );
    return(@cmdArray);
}

# what to send to login ?
sub getLogin {
    my $this = shift;
    @login = ("");
    return(@login);
}

# here we can test everything besides buffer overflows and format strings
sub testMisc {
    my $this = shift;
    return();
}

sub usage {
}

1;
