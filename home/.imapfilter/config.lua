-- Utility function to get IMAP password from ~/.password.imapfilter
-- TODO(pbourke): warn if not chmod 0400
function get_imap_password(file)
    local home = os.getenv("HOME")
    local file = home .. "/" .. file
    local str = io.open(file):read()
    return str;
end

oracle_account = IMAP {
  server = 'stbeehive.oracle.com',
  username = 'paul.bourke@oracle.com',
  password = get_imap_password(".password.imapfilter"),
  ssl = 'ssl3',
}

openstack_dev = oracle_account["INBOX"]:contain_to("openstack-dev@lists.openstack.org")
openstack_dev:move_messages(oracle_account["INBOX/openstack/openstack-dev"])

openstack_dev_digests = oracle_account["INBOX"]:contain_subject("OpenStack Developer Mailing List Digest")
openstack_dev:move_messages(oracle_account["INBOX/openstack/openstack-dev/weekly-digest"])

openstack_dev_ekko = oracle_account["INBOX"]:contain_subject("[ekko]")
openstack_dev:move_messages(oracle_account["INBOX/openstack/openstack-dev/ekko"])

openstack_dev_kolla = oracle_account["INBOX"]:contain_subject("[kolla]")
openstack_dev:move_messages(oracle_account["INBOX/openstack/openstack-dev/kolla"])

openstack_reviews = oracle_account["INBOX"]:contain_to("review@openstack.org")
openstack_dev:move_messages(oracle_account["INBOX/openstack/review.openstack.org"])
