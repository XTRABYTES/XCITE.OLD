/**
 * TODO: Credit bitcoin source
 */

#ifndef BASE58_HPP
#define BASE58_HPP

std::string EncodeBase58(const unsigned char* pbegin, const unsigned char* pend);
bool DecodeBase58(const char* psz, std::vector<unsigned char>& vch);

#endif
