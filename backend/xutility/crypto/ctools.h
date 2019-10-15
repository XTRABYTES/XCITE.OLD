/**

 * Filename: ctools.h
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 *

		Copyright (c) 2009-2010 Satoshi Nakamoto
		Copyright (c) 2017-2019 Zoltan Szabo & XTRABYTES developers
		
		Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
		associated documentation files (the “Software”), to deal in the Software without restriction, 
		including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
		and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
		subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all copies or substantial 
		portions of the Software.
		
		THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
		LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
		IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
		WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
		SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 

*/

#ifndef CTOOLS_H
#define CTOOLS_H

#include <string>
#include <vector>

#include <boost/foreach.hpp>
#include <boost/variant.hpp>

#include <openssl/sha.h>
#include <openssl/ripemd.h>

#include "allocators.h"
#include "numbers.h"
#include "../transaction/serialize.h"


template<typename T1>
inline uint256 Hash(const T1 pbegin, const T1 pend)
{
    static unsigned char pblank[1];
    uint256 hash1;
    SHA256((pbegin == pend ? pblank : (unsigned char*)&pbegin[0]), (pend - pbegin) * sizeof(pbegin[0]), (unsigned char*)&hash1);
    uint256 hash2;
    SHA256((unsigned char*)&hash1, sizeof(hash1), (unsigned char*)&hash2);
    return hash2;
}


template<typename T1>
inline uint160 Hash160(const T1 pbegin, const T1 pend)
{
    static unsigned char pblank[1];
    uint256 hash1;
    SHA256((pbegin == pend ? pblank : (unsigned char*)&pbegin[0]), (pend - pbegin) * sizeof(pbegin[0]), (unsigned char*)&hash1);
    uint160 hash2;
    RIPEMD160((unsigned char*)&hash1, sizeof(hash1), (unsigned char*)&hash2);
    return hash2;
}

inline uint160 Hash160(const std::vector<unsigned char>& vch)
{
    return Hash160(vch.begin(), vch.end());
}

class CHashWriter
{
private:
    SHA256_CTX ctx;

public:
    int nType;
    int nVersion;

    void Init() {
        SHA256_Init(&ctx);
    }

    CHashWriter(int nTypeIn, int nVersionIn) : nType(nTypeIn), nVersion(nVersionIn) {
        Init();
    }

    CHashWriter& write(const char *pch, size_t size) {
        SHA256_Update(&ctx, pch, size);
        return (*this);
    }

    // invalidates the object
    uint256 GetHash() {
        uint256 hash1;
        SHA256_Final((unsigned char*)&hash1, &ctx);
        uint256 hash2;
        SHA256((unsigned char*)&hash1, sizeof(hash1), (unsigned char*)&hash2);
        return hash2;
    }

    template<typename T>
    CHashWriter& operator<<(const T& obj) {
        // Serialize to this stream
        ::Serialize(*this, obj, nType, nVersion);
        return (*this);
    }
};

// secp256k1:
// const unsigned int PRIVATE_KEY_SIZE = 279;
// const unsigned int PUBLIC_KEY_SIZE  = 65;
// const unsigned int SIGNATURE_SIZE   = 72;
//
// see www.keylength.com
// script supports up to 75 for single byte push

/** A reference to a CKey: the Hash160 of its serialized public key */
class CKeyID : public uint160
{
public:
    CKeyID() : uint160(0) { }
    CKeyID(const uint160 &in) : uint160(in) { }
};

/** A reference to a CScript: the Hash160 of its serialization (see script.h) */
class CScriptID : public uint160
{
public:
    CScriptID() : uint160(0) { }
    CScriptID(const uint160 &in) : uint160(in) { }
};

/** An encapsulated public key. */
class CPubKey {
private:
    // Just store the serialized data.
    // Its length can very cheaply be computed from the first byte.
    unsigned char vch[65];

    // Compute the length of a pubkey with a given first byte.
    unsigned int static GetLen(unsigned char chHeader) {
        if (chHeader == 2 || chHeader == 3)
            return 33;
        if (chHeader == 4 || chHeader == 6 || chHeader == 7)
            return 65;
        return 0;
    }

    // Set this key data to be invalid
    void Invalidate() {
        vch[0] = 0xFF;
    }

public:
    // Construct an invalid public key.
    CPubKey() {
        Invalidate();
    }

    // Initialize a public key using begin/end iterators to byte data.
    template<typename T>
    void Set(const T pbegin, const T pend) {
        int len = pend == pbegin ? 0 : GetLen(pbegin[0]);
        if (len && len == (pend-pbegin))
            memcpy(vch, (unsigned char*)&pbegin[0], len);
        else
            Invalidate();
    }

    // Construct a public key using begin/end iterators to byte data.
    template<typename T>
    CPubKey(const T pbegin, const T pend) {
        Set(pbegin, pend);
    }

    // Construct a public key from a byte vector.
    CPubKey(const std::vector<unsigned char> &vch) {
        Set(vch.begin(), vch.end());
    }

    // Simple read-only vector-like interface to the pubkey data.
    unsigned int size() const { return GetLen(vch[0]); }
    const unsigned char *begin() const { return vch; }
    const unsigned char *end() const { return vch+size(); }
    const unsigned char &operator[](unsigned int pos) const { return vch[pos]; }

    // Comparator implementation.
    friend bool operator==(const CPubKey &a, const CPubKey &b) {
        return a.vch[0] == b.vch[0] &&
               memcmp(a.vch, b.vch, a.size()) == 0;
    }
    friend bool operator!=(const CPubKey &a, const CPubKey &b) {
        return !(a == b);
    }
    friend bool operator<(const CPubKey &a, const CPubKey &b) {
        return a.vch[0] < b.vch[0] ||
               (a.vch[0] == b.vch[0] && memcmp(a.vch, b.vch, a.size()) < 0);
    }
    // Get the KeyID of this public key (hash of its serialization)
    CKeyID GetID() const {
        return CKeyID(Hash160(vch, vch+size()));
    }

    // Get the 256-bit hash of this public key.
    uint256 GetHash() const {
        return Hash(vch, vch+size());
    }

    // just check syntactic correctness.
    bool IsValid() const {
        return size() > 0;
    }

    // fully validate whether this is a valid public key (more expensive than IsValid())
    bool IsFullyValid() const;

    // Check whether this is a compressed public key.
    bool IsCompressed() const {
        return size() == 33;
    }

    // Verify a DER signature (~72 bytes).
    // If this public key is not fully valid, the return value will be false.
    bool Verify(const uint256 &hash, const std::vector<unsigned char>& vchSig) const;

    // Verify a compact signature (~65 bytes).
    // See CKey::SignCompact.
    bool VerifyCompact(const uint256 &hash, const std::vector<unsigned char>& vchSig) const;

    // Recover a public key from a compact signature.
    bool RecoverCompact(const uint256 &hash, const std::vector<unsigned char>& vchSig);

    // Turn this public key into an uncompressed public key.
    bool Decompress();
};


// secure_allocator is defined in allocators.h
// CPrivKey is a serialized private key, with all parameters included (279 bytes)
typedef std::vector<unsigned char, secure_allocator<unsigned char> > CPrivKey;

/** An encapsulated private key. */
class CKey {
private:
    // Whether this private key is valid. We check for correctness when modifying the key
    // data, so fValid should always correspond to the actual state.
    bool fValid;

    // Whether the public key corresponding to this private key is (to be) compressed.
    bool fCompressed;

    // The actual byte data
    unsigned char vch[32];

    // Check whether the 32-byte array pointed to be vch is valid keydata.
    bool static Check(const unsigned char *vch);
public:

    // Construct an invalid private key.
    CKey() : fValid(false) {
        LockObject(vch);
    }

    // Copy constructor. This is necessary because of memlocking.
    CKey(const CKey &secret) : fValid(secret.fValid), fCompressed(secret.fCompressed) {
        LockObject(vch);
        memcpy(vch, secret.vch, sizeof(vch));
    }

    // Destructor (again necessary because of memlocking).
    ~CKey() {
        UnlockObject(vch);
    }

    // Initialize using begin and end iterators to byte data.
    template<typename T>
    void Set(const T pbegin, const T pend, bool fCompressedIn) {
        if (pend - pbegin != 32) {
            fValid = false;
            return;
        }
        if (Check(&pbegin[0])) {
            memcpy(vch, (unsigned char*)&pbegin[0], 32);
            fValid = true;
            fCompressed = fCompressedIn;
        } else {
            fValid = false;
        }
    }

    // Simple read-only vector-like interface.
    unsigned int size() const { return (fValid ? 32 : 0); }
    const unsigned char *begin() const { return vch; }
    const unsigned char *end() const { return vch + size(); }

    // Check whether this private key is valid.
    bool IsValid() const { return fValid; }

    // Check whether the public key corresponding to this private key is (to be) compressed.
    bool IsCompressed() const { return fCompressed; }

    // Initialize from a CPrivKey (serialized OpenSSL private key data).
    bool SetPrivKey(const CPrivKey &vchPrivKey, bool fCompressed);

    // Generate a new private key using a cryptographic PRNG.
    void MakeNewKey(bool fCompressed);

    // Convert the private key to a CPrivKey (serialized OpenSSL private key data).
    // This is expensive.
    CPrivKey GetPrivKey() const;

    // Compute the public key from a private key.
    // This is expensive.
    CPubKey GetPubKey() const;

    // Create a DER-serialized signature.
    bool Sign(const uint256 &hash, std::vector<unsigned char>& vchSig) const;

    // Create a compact signature (65 bytes), which allows reconstructing the used public key.
    // The format is one header byte, followed by two times 32 bytes for the serialized r and s values.
    // The header byte: 0x1B = first key with even y, 0x1C = first key with odd y,
    //                  0x1D = second key with even y, 0x1E = second key with odd y,
    //                  add 0x04 for compressed keys.
    bool SignCompact(const uint256 &hash, std::vector<unsigned char>& vchSig) const;
};


class CNoDestination {
public:
    friend bool operator==(const CNoDestination &a, const CNoDestination &b) { return true; }
    friend bool operator<(const CNoDestination &a, const CNoDestination &b) { return true; }
};

/** A txout script template with a specific destination. It is either:
 *  * CNoDestination: no destination set
 *  * CKeyID: TX_PUBKEYHASH destination
 *  * CScriptID: TX_SCRIPTHASH destination
 *  A CTxDestination is the internal data type encoded in a CXCiteAddress
 */

//typedef boost::variant<CNoDestination, CKeyID> CTxDestination;
typedef boost::variant<CNoDestination, CKeyID, CScriptID> CTxDestination;


static const char* pszBase58 = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";

// Encode a byte sequence as a base58-encoded string
inline std::string EncodeBase58(const unsigned char* pbegin, const unsigned char* pend)
{
    CAutoBN_CTX pctx;
    CBigNum bn58 = 58;
    CBigNum bn0 = 0;

    // Convert big endian data to little endian
    // Extra zero at the end make sure bignum will interpret as a positive number
    std::vector<unsigned char> vchTmp(pend-pbegin+1, 0);
    reverse_copy(pbegin, pend, vchTmp.begin());

    // Convert little endian data to bignum
    CBigNum bn;
    bn.setvch(vchTmp);

    // Convert bignum to std::string
    std::string str;
    // Expected size increase from base58 conversion is approximately 137%
    // use 138% to be safe
    str.reserve((pend - pbegin) * 138 / 100 + 1);
    CBigNum dv;
    CBigNum rem;
    while (bn > bn0)
    {
        if (!BN_div(dv.to_bignum(), rem.to_bignum(), bn.to_bignum(), bn58.to_bignum(), pctx))
            throw bignum_error("EncodeBase58 : BN_div failed");
        bn = dv;
        unsigned int c = rem.getulong();
        str += pszBase58[c];
    }

    // Leading zeroes encoded as base58 zeros
    for (const unsigned char* p = pbegin; p < pend && *p == 0; p++)
        str += pszBase58[0];

    // Convert little endian std::string to big endian
    reverse(str.begin(), str.end());
    return str;
}

// Encode a byte vector as a base58-encoded string
inline std::string EncodeBase58(const std::vector<unsigned char>& vch)
{
    return EncodeBase58(&vch[0], &vch[0] + vch.size());
}

// Decode a base58-encoded string psz into byte vector vchRet
// returns true if decoding is successful
inline bool DecodeBase58(const char* psz, std::vector<unsigned char>& vchRet)
{
    CAutoBN_CTX pctx;
    vchRet.clear();
    CBigNum bn58 = 58;
    CBigNum bn = 0;
    CBigNum bnChar;
    while (isspace(*psz))
        psz++;

    // Convert big endian string to bignum
    for (const char* p = psz; *p; p++)
    {
        const char* p1 = strchr(pszBase58, *p);
        if (p1 == NULL)
        {
            while (isspace(*p))
                p++;
            if (*p != '\0')
                return false;
            break;
        }
        bnChar.setulong(p1 - pszBase58);
        if (!BN_mul(bn.to_bignum(), bn.to_bignum(), bn58.to_bignum(), pctx))
            throw bignum_error("DecodeBase58 : BN_mul failed");
        bn += bnChar;
    }

    // Get bignum as little endian data
    std::vector<unsigned char> vchTmp = bn.getvch();

    // Trim off sign byte if present
    if (vchTmp.size() >= 2 && vchTmp.end()[-1] == 0 && vchTmp.end()[-2] >= 0x80)
        vchTmp.erase(vchTmp.end()-1);

    // Restore leading zeros
    int nLeadingZeros = 0;
    for (const char* p = psz; *p == pszBase58[0]; p++)
        nLeadingZeros++;
    vchRet.assign(nLeadingZeros + vchTmp.size(), 0);

    // Convert little endian data to big endian
    reverse_copy(vchTmp.begin(), vchTmp.end(), vchRet.end() - vchTmp.size());
    return true;
}

// Decode a base58-encoded string str into byte vector vchRet
// returns true if decoding is successful
inline bool DecodeBase58(const std::string& str, std::vector<unsigned char>& vchRet)
{
    return DecodeBase58(str.c_str(), vchRet);
}




// Encode a byte vector to a base58-encoded string, including checksum
inline std::string EncodeBase58Check(const std::vector<unsigned char>& vchIn)
{
    // add 4-byte hash check to the end
    std::vector<unsigned char> vch(vchIn);
    uint256 hash = Hash(vch.begin(), vch.end());
    vch.insert(vch.end(), (unsigned char*)&hash, (unsigned char*)&hash + 4);
    return EncodeBase58(vch);
}

// Decode a base58-encoded string psz that includes a checksum, into byte vector vchRet
// returns true if decoding is successful
inline bool DecodeBase58Check(const char* psz, std::vector<unsigned char>& vchRet)
{
    if (!DecodeBase58(psz, vchRet))
        return false;
    if (vchRet.size() < 4)
    {
        vchRet.clear();
        return false;
    }
    uint256 hash = Hash(vchRet.begin(), vchRet.end()-4);
    if (memcmp(&hash, &vchRet.end()[-4], 4) != 0)
    {
        vchRet.clear();
        return false;
    }
    vchRet.resize(vchRet.size()-4);
    return true;
}

// Decode a base58-encoded string str that includes a checksum, into byte vector vchRet
// returns true if decoding is successful
inline bool DecodeBase58Check(const std::string& str, std::vector<unsigned char>& vchRet)
{
    return DecodeBase58Check(str.c_str(), vchRet);
}


/** Base class for all base58-encoded data */
class CBase58Data
{
protected:
    // the version byte
    unsigned char nVersion;

    // the actually encoded data
    typedef std::vector<unsigned char, zero_after_free_allocator<unsigned char> > vector_uchar;
    vector_uchar vchData;

    CBase58Data()
    {
        nVersion = 0;
        vchData.clear();
    }

    void SetData(int nVersionIn, const void* pdata, size_t nSize)
    {
        nVersion = nVersionIn;
        vchData.resize(nSize);
        if (!vchData.empty())
            memcpy(&vchData[0], pdata, nSize);
    }

    void SetData(int nVersionIn, const unsigned char *pbegin, const unsigned char *pend)
    {
        SetData(nVersionIn, (void*)pbegin, pend - pbegin);
    }

public:
    bool SetString(const char* psz)
    {
        std::vector<unsigned char> vchTemp;
        DecodeBase58Check(psz, vchTemp);
        if (vchTemp.empty())
        {
            vchData.clear();
            nVersion = 0;
            return false;
        }
        nVersion = vchTemp[0];
        vchData.resize(vchTemp.size() - 1);
        if (!vchData.empty())
            memcpy(&vchData[0], &vchTemp[1], vchData.size());
        OPENSSL_cleanse(&vchTemp[0], vchData.size());
        return true;
    }

    bool SetString(const std::string& str)
    {
        return SetString(str.c_str());
    }

    std::string ToString() const
    {
        std::vector<unsigned char> vch(1, nVersion);
        vch.insert(vch.end(), vchData.begin(), vchData.end());
        return EncodeBase58Check(vch);
    }

    int CompareTo(const CBase58Data& b58) const
    {
        if (nVersion < b58.nVersion) return -1;
        if (nVersion > b58.nVersion) return  1;
        if (vchData < b58.vchData)   return -1;
        if (vchData > b58.vchData)   return  1;
        return 0;
    }

    bool operator==(const CBase58Data& b58) const { return CompareTo(b58) == 0; }
    bool operator<=(const CBase58Data& b58) const { return CompareTo(b58) <= 0; }
    bool operator>=(const CBase58Data& b58) const { return CompareTo(b58) >= 0; }
    bool operator< (const CBase58Data& b58) const { return CompareTo(b58) <  0; }
    bool operator> (const CBase58Data& b58) const { return CompareTo(b58) >  0; }
};

/** base58-encoded XCite addresses.
 * Public-key-hash-addresses have version 0 (or 111 testnet).
 * The data vector contains RIPEMD160(SHA256(pubkey)), where pubkey is the serialized public key.
 * Script-hash-addresses have version 5 (or 196 testnet).
 * The data vector contains RIPEMD160(SHA256(cscript)), where cscript is the serialized redemption script.
 */
class CXCiteAddress;
class CXCiteAddressVisitor : public boost::static_visitor<bool>
{
private:
    CXCiteAddress *addr;
public:
    CXCiteAddressVisitor(CXCiteAddress *addrIn) : addr(addrIn) { }
    bool operator()(const CKeyID &id) const;
    bool operator()(const CNoDestination &no) const;
};

class CXCiteAddress : public CBase58Data
{
private:
     unsigned char AddressNetwork = 0;	
public:
    void SetAddressNetwork( const unsigned char AddressNetworkID ) {
    	  AddressNetwork = AddressNetworkID;
    }
    
    unsigned char GetAddressNetwork() const {
       return AddressNetwork;    
    }

    bool Set(const CKeyID &id) {
        SetData(GetAddressNetwork(), &id, 20);
        return true;
    }

    bool Set(const CTxDestination &dest)
    {
        return boost::apply_visitor(CXCiteAddressVisitor(this), dest);
    }

  
    bool IsValid() const
    {
        unsigned int nExpectedSize = 20;
        return ( ( nVersion == GetAddressNetwork()) && (vchData.size() == nExpectedSize) );
    }


    CXCiteAddress()
    {
    }

    CXCiteAddress(const CTxDestination &dest, const unsigned char AddressNetworkID)    
    {
    	  SetAddressNetwork( AddressNetworkID );
        Set(dest);
    }

    CXCiteAddress(const std::string& strAddress, const unsigned char AddressNetworkID)
    {
    	  SetAddressNetwork( AddressNetworkID );
        SetString(strAddress);
    }

    CXCiteAddress(const char* pszAddress, const unsigned char AddressNetworkID)
    {
    	  SetAddressNetwork( AddressNetworkID );
        SetString(pszAddress);
    }


    CTxDestination Get() const {
        uint160 id;
        memcpy(&id, &vchData[0], 20);
        return CKeyID(id);    
    }

    bool GetKeyID(CKeyID &keyID) const {
        if (!IsValid())
            return false;
        if (nVersion != GetAddressNetwork()) return false;
            
            uint160 id;
            memcpy(&id, &vchData[0], 20);
            keyID = CKeyID(id);
            return true;
        
    }

};

bool inline CXCiteAddressVisitor::operator()(const CKeyID &id) const         { return addr->Set(id); }
bool inline CXCiteAddressVisitor::operator()(const CNoDestination &id) const { return false; }

/** A base58-encoded secret key */
class CXCiteSecret : public CBase58Data
{
  private:
     unsigned char AddressNetwork = 0;	
  public:
    void SetAddressNetwork( const unsigned char AddressNetworkID ) {
    	  AddressNetwork = AddressNetworkID;
    }
    
    unsigned char GetAddressNetwork() const {
       return AddressNetwork;    
    }
	
    void SetKey(const CKey& vchSecret,const unsigned char AddressNetworkID)
    {
    	  SetAddressNetwork( AddressNetworkID );
        assert(vchSecret.IsValid());
        SetData(GetAddressNetwork() + 128, vchSecret.begin(), vchSecret.size());
        if (vchSecret.IsCompressed())
            vchData.push_back(1);
    }

    CKey GetKey()
    {
        CKey ret;
        ret.Set(&vchData[0], &vchData[32], vchData.size() > 32 && vchData[32] == 1);
        return ret;
    }

    bool IsValid() const
    {
        if ((GetAddressNetwork() + 128) != nVersion) return false;
        return  (vchData.size() == 32 || (vchData.size() == 33 && vchData[32] == 1));
    }

    bool SetString(const char* pszSecret,const unsigned char AddressNetworkID)    
    {
    	  SetAddressNetwork( AddressNetworkID );
        return CBase58Data::SetString(pszSecret) && IsValid();
    }

    bool SetString(const std::string& strSecret,const unsigned char AddressNetworkID)
    {
        return SetString(strSecret.c_str(),AddressNetworkID);
    }

    CXCiteSecret(const CKey& vchSecret, const unsigned char AddressNetworkID)
    {
        SetKey(vchSecret,AddressNetworkID);
    }

    CXCiteSecret()
    {
    }
};

template<typename T>
std::string HexStr(const T itbegin, const T itend, bool fSpaces=false)
{
    std::string rv;
    static const char hexmap[16] = { '0', '1', '2', '3', '4', '5', '6', '7',
                                     '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    rv.reserve((itend-itbegin)*3);
    for(T it = itbegin; it < itend; ++it)
    {
        unsigned char val = (unsigned char)(*it);
        if(fSpaces && it != itbegin)
            rv.push_back(' ');
        rv.push_back(hexmap[val>>4]);
        rv.push_back(hexmap[val&15]);
    }

    return rv;
}


template<typename T>
inline std::string HexStr(const T& vch, bool fSpaces=false)
{
    return HexStr(vch.begin(), vch.end(), fSpaces);
}

extern std::vector<unsigned char> ParseHexcstr(const char* psz);

#endif // CTOOLS_H
